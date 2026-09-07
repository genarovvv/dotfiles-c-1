local map = vim.keymap.set

local runners = {
    c          = { compile = "gcc $file -O2 -Wall -Wextra -lm -o $out",            run = "$out $args"          },
    cpp        = { compile = "g++ $file -O2 -std=c++17 -Wall -Wextra -o $out",     run = "$out $args"          },
    rust       = { compile = "rustc $file -o $out",                                 run = "$out $args"          },
    python     = { run = "python3 $file $args"                                                                  },
    sh         = { run = "bash $file $args"                                                                     },
    bash       = { run = "bash $file $args"                                                                     },
    lua        = { run = "lua $file $args"                                                                      },
    javascript = { run = "node $file $args"                                                                     },
    typescript = { run = "npx ts-node $file $args"                                                              },
    asm        = { compile = "nasm -f elf64 $file -o /tmp/nvim_run_$base.o && ld /tmp/nvim_run_$base.o -o $out", run = "$out $args" },
}

local function sub(t, v) return (t:gsub("%$(%w+)", v)) end

local function build_cmd(ft, args)
    local r = runners[ft]
    if not r then return nil end
    local vars = {
        file = vim.fn.expand("%:p"),
        out  = "/tmp/nvim_run_" .. vim.fn.expand("%:t:r"),
        base = vim.fn.expand("%:t:r"),
        args = args,
    }
    local parts = { "clear" }
    if r.compile then
        local cc = sub(r.compile, vars)
        table.insert(parts, "echo '$ " .. cc .. "'")
        table.insert(parts, cc)
    end
    if r.run then
        local rc = sub(r.run, vars)
        table.insert(parts, "echo '$ " .. rc .. "'")
        table.insert(parts, rc)
    end
    return table.concat(parts, " && ")
end

local function find_out_win()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.b[vim.api.nvim_win_get_buf(win)]._is_runner then
            return win, vim.api.nvim_win_get_buf(win)
        end
    end
    return nil, nil
end

local function open_out_win(src_win)
    local out_win, out_buf = find_out_win()
    if out_win and vim.api.nvim_win_is_valid(out_win) then
        local old = vim.b[out_buf]._runner_job
        if old then pcall(vim.fn.jobstop, old) end
        vim.api.nvim_set_current_win(out_win)
        vim.cmd("enew")
        out_buf = vim.api.nvim_get_current_buf()
    else
        vim.api.nvim_set_current_win(src_win)
        vim.cmd("botright 16new")
        out_win = vim.api.nvim_get_current_win()
        out_buf = vim.api.nvim_get_current_buf()
    end
    vim.b[out_buf]._is_runner = true
    local wo = vim.wo[out_win]
    wo.number         = false
    wo.relativenumber = false
    wo.signcolumn     = "no"
    wo.statusline     = "  Output  [q to close]"
    wo.wrap           = true
    -- Esc: exit terminal mode (to scroll), but stay in the window
    vim.keymap.set("t", "<Esc>",     [[<C-\><C-n>]],  { buffer = out_buf, silent = true })
    vim.keymap.set("n", "q",         "<cmd>close<CR>", { buffer = out_buf, silent = true })
    vim.keymap.set("n", "<leader>o", "<cmd>close<CR>", { buffer = out_buf, silent = true })
    -- i / a: go back to insert mode inside the terminal (to type input)
    vim.keymap.set("n", "i", "i", { buffer = out_buf, noremap = true })
    vim.keymap.set("n", "a", "a", { buffer = out_buf, noremap = true })
    return out_win, out_buf
end

local function toggle_output()
    local out_win, _ = find_out_win()
    if out_win and vim.api.nvim_win_is_valid(out_win) then
        vim.api.nvim_win_close(out_win, false)
    end
end

local function run()
    vim.cmd("w")
    local ft = vim.bo.filetype
    if not runners[ft] then
        vim.notify("No runner for: " .. (ft == "" and "unknown" or ft), vim.log.levels.WARN)
        return
    end
    vim.ui.input({ prompt = "  Arguments (Enter to skip): " }, function(args)
        if args == nil then return end
        args = vim.trim(args)
        local cmd = build_cmd(ft, args)
        if not cmd then return end
        local src_win          = vim.api.nvim_get_current_win()
        local out_win, out_buf = open_out_win(src_win)
        local job_id = vim.fn.termopen(cmd, {
            on_exit = function()
                -- When program finishes, go back to normal mode automatically
                vim.schedule(function()
                    if vim.api.nvim_win_is_valid(out_win) then
                        vim.api.nvim_win_call(out_win, function()
                            vim.cmd("stopinsert")
                        end)
                    end
                end)
            end,
        })
        vim.b[out_buf]._runner_job = job_id
        vim.b[out_buf]._is_runner  = true

        -- Enter insert mode in terminal so interactive programs get input immediately
        vim.api.nvim_set_current_win(out_win)
        vim.cmd("startinsert")

        -- After a short delay, return focus to editor
        -- User can click the output panel or use Ctrl+J to go back down if needed
        vim.defer_fn(function()
            if vim.api.nvim_win_is_valid(src_win) then
                vim.api.nvim_set_current_win(src_win)
            end
        end, 80)
    end)
end

map("n", "<F5>",      run,           { silent = true, desc = "Run"                 })
map("n", "<C-CR>",    run,           { silent = true, desc = "Run"                 })
map("n", "<leader>r", run,           { silent = true, desc = "Run file"            })
map("n", "<leader>o", toggle_output, { silent = true, desc = "Toggle output panel" })
map("i", "<C-CR>", function()
    vim.cmd("stopinsert")
    vim.defer_fn(run, 10)
end, { silent = true })

vim.api.nvim_create_user_command("Run", run, {})

map("n", "<F6>", function()
    local cwd   = vim.fn.getcwd()
    local build
    if vim.fn.filereadable(cwd .. "/Cargo.toml") == 1 then
        build = "cargo build 2>&1"
    elseif vim.fn.filereadable(cwd .. "/Makefile") == 1 then
        build = "make 2>&1"
    elseif vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
        build = "cmake --build build 2>&1"
    else
        vim.notify("No Makefile, Cargo.toml or CMakeLists.txt found", vim.log.levels.WARN)
        return
    end
    local cmd = "clear; cd " .. vim.fn.shellescape(cwd) .. " && echo '$ " .. build .. "' && " .. build
    local src_win          = vim.api.nvim_get_current_win()
    local out_win, out_buf = open_out_win(src_win)
    local job_id = vim.fn.termopen(cmd, { on_exit = function() end })
    vim.b[out_buf]._runner_job = job_id
    vim.b[out_buf]._is_runner  = true
    vim.defer_fn(function()
        if vim.api.nvim_win_is_valid(src_win) then
            vim.api.nvim_set_current_win(src_win)
        end
    end, 80)
end, { desc = "Build project" })
