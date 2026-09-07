local map = vim.keymap.set

map("n", "K",          vim.lsp.buf.hover,          { desc = "Documentacion" })
map("n", "<leader>gD", vim.lsp.buf.declaration,    { desc = "Declaracion" })
map("n", "<leader>gd", vim.lsp.buf.definition,     { desc = "Definicion" })
map("n", "<leader>gr", vim.lsp.buf.references,     { desc = "Referencias" })
map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Implementacion" })
map("n", "<leader>ca", vim.lsp.buf.code_action,    { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename,         { desc = "Renombrar simbolo" })
map("n", "<leader>gf", function() require("conform").format({ async = true }) end, { desc = "Formatear buffer" })
map("n", "[d", vim.diagnostic.goto_prev,  { desc = "Diagnostico anterior" })
map("n", "]d", vim.diagnostic.goto_next,  { desc = "Diagnostico siguiente" })
map("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Ver diagnostico" })
