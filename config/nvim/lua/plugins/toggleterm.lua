return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { "<C-\\>",    "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle terminal" },
        { "<leader>t", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal"         },
        { "<leader>tf","<cmd>ToggleTerm direction=float<CR>",      desc = "Terminal flotante"},
    },
    config = function()
        require("toggleterm").setup({
            size = function(term)
                if term.direction == "horizontal" then return 14
                elseif term.direction == "vertical" then
                    return math.floor(vim.o.columns * 0.35)
                end
            end,
            shade_terminals   = false,
            start_in_insert   = true,
            insert_mappings   = false,
            terminal_mappings = true,
            persist_size      = false,
            persist_mode      = false,
            direction         = "horizontal",
            close_on_exit     = false,
            shell             = vim.o.shell,
            auto_scroll       = true,
            float_opts        = { border = "curved", winblend = 0 },
            highlights = {
                Normal      = { link = "Normal" },
                NormalFloat = { link = "Normal" },
                FloatBorder = { link = "FloatBorder" },
            },
        })
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern  = "term://*toggleterm*",
            callback = function()
                vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = 0, silent = true })
                vim.opt_local.number         = false
                vim.opt_local.relativenumber = false
                vim.opt_local.signcolumn     = "no"
            end,
        })
    end,
}
