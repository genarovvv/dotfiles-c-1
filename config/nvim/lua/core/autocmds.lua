local augroup  = vim.api.nvim_create_augroup
local autocmd  = vim.api.nvim_create_autocmd

-- Resaltar al copiar
autocmd("TextYankPost", {
    desc     = "Resaltar al copiar",
    group    = augroup("highlight_yank", { clear = true }),
    callback = function() vim.highlight.on_yank() end,
})

-- Eliminar espacios al final al guardar
autocmd("BufWritePre", {
    desc     = "Trim whitespace",
    group    = augroup("trim_whitespace", { clear = true }),
    callback = function()
        local save = vim.fn.winsaveview()
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.winrestview(save)
    end,
})

-- Indentacion por tipo de archivo
autocmd("FileType", {
    pattern  = { "c", "cpp", "python", "lua", "rust" },
    callback = function()
        vim.opt_local.tabstop   = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab  = true
    end,
})

-- Terminal: sin numeros ni signcolumn
autocmd("TermOpen", {
    group    = augroup("terminal_settings", { clear = true }),
    callback = function()
        vim.opt_local.number         = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn     = "no"
    end,
})

-- :q cierra nvim completo aunque haya splits abiertos
-- Si hay solo 1 buffer "real" abierto, salir todo
vim.api.nvim_create_user_command("Q", function()
    vim.cmd("qa")
end, { desc = "Salir todo" })

-- Sobrescribir :q para que cierre todo cuando el unico buffer real es el editor
-- (ignora terminales/output del runner)
vim.api.nvim_create_autocmd("QuitPre", {
    group = augroup("smart_quit", { clear = true }),
    callback = function()
        local wins = vim.api.nvim_list_wins()
        -- Contar ventanas que NO son terminales del runner
        local real_wins = 0
        for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            local bt  = vim.bo[buf].buftype
            -- Si no es terminal del runner, es una ventana "real"
            if not vim.b[buf]._is_runner then
                real_wins = real_wins + 1
            end
        end
        -- Si solo queda 1 ventana real (la que se esta cerrando), cerrar todo
        if real_wins <= 1 then
            vim.cmd("qa!")
        end
    end,
})
