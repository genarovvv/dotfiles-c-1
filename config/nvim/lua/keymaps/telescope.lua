local map = vim.keymap.set
local tel = function(picker, opts)
    return function() require("telescope.builtin")[picker](opts or {}) end
end

-- Ctrl+P: buscar archivos (como VSCode)
-- Ctrl+F: busqueda nativa en archivo (definido en search.lua)
map("n", "<C-p>",      tel("find_files"),           { desc = "Buscar archivos" })
map("n", "<leader>b",  tel("buffers"),              { desc = "Buffers" })
map("n", "<leader>ff", tel("find_files"),           { desc = "Buscar archivos" })
map("n", "<leader>fg", tel("live_grep"),            { desc = "Buscar en proyecto" })
map("n", "<leader>fh", tel("help_tags"),            { desc = "Ayuda" })
map("n", "<leader>fr", tel("oldfiles"),             { desc = "Archivos recientes" })
map("n", "<leader>fs", tel("lsp_document_symbols"), { desc = "Simbolos" })
map("n", "<leader>fd", tel("diagnostics"),          { desc = "Diagnosticos" })
map("n", "<leader>gc", tel("git_commits"),          { desc = "Git commits" })
map("n", "<leader>gb", tel("git_branches"),         { desc = "Git branches" })
map("n", "<leader>gs", tel("git_status"),           { desc = "Git status" })
