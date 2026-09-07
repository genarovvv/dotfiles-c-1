-- Ctrl+F = busqueda nativa de nvim (/)
-- Sin telescope, sin floating, resalta en vivo mientras escribes
-- n / N para navegar resultados, Esc para limpiar highlight

local map = vim.keymap.set

map({ "n", "i" }, "<C-f>", function()
    if vim.fn.mode() == "i" then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
        vim.defer_fn(function() vim.api.nvim_feedkeys("/", "n", false) end, 10)
    else
        vim.api.nvim_feedkeys("/", "n", false)
    end
end, { noremap = true, desc = "Buscar en archivo" })
