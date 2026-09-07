local map = vim.keymap.set

-- ── Clipboard ─────────────────────────────────────────────────────────────────
-- Solo en visual para copiar, NO remap de p en normal (evita conflictos)
map("v", "<C-c>", '"+y', { noremap = true, desc = "Copy" })
-- Pegar en insert con Ctrl+V
map("i", "<C-v>", "<C-r>+", { noremap = true, desc = "Paste insert" })

-- ── Save (Ctrl+S) ─────────────────────────────────────────────────────────────
map({ "n", "i", "v" }, "<C-s>", function()
    local mode = vim.fn.mode()
    if mode == "i" or mode == "v" then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
        vim.defer_fn(function() vim.cmd("w") end, 10)
    else
        vim.cmd("w")
    end
end, { noremap = true, silent = true, desc = "Save" })

-- ── Undo / Redo ───────────────────────────────────────────────────────────────
map("n", "<C-z>", "u",      { noremap = true, desc = "Undo" })
map("i", "<C-z>", "<ESC>u", { noremap = true, desc = "Undo insert" })
map("n", "<C-y>", "<C-r>",  { noremap = true, desc = "Redo" })

-- ── Quit ──────────────────────────────────────────────────────────────────────
map("n", "<leader>w", ":w<CR>",   { noremap = true, desc = "Save" })
map("n", "<leader>q", ":q<CR>",   { noremap = true, desc = "Quit" })
map("n", "<leader>Q", ":qa!<CR>", { noremap = true, desc = "Quit all" })

-- ── Select all ────────────────────────────────────────────────────────────────
map("n", "<C-a>", "gg<S-v>G", { noremap = true, desc = "Select all" })

-- ── Indent in visual ──────────────────────────────────────────────────────────
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv",  { noremap = true, silent = true })

-- ── Navigate splits (Ctrl+hjkl) ───────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { noremap = true, desc = "Panel left"  })
map("n", "<C-j>", "<C-w>j", { noremap = true, desc = "Panel down"  })
map("n", "<C-k>", "<C-w>k", { noremap = true, desc = "Panel up"    })
map("n", "<C-l>", "<C-w>l", { noremap = true, desc = "Panel right" })

-- ── Resize splits ─────────────────────────────────────────────────────────────
map("n", "<C-Up>",    ":resize -3<CR>",          { noremap = true, silent = true })
map("n", "<C-Down>",  ":resize +3<CR>",           { noremap = true, silent = true })
map("n", "<C-Left>",  ":vertical resize -3<CR>",  { noremap = true, silent = true })
map("n", "<C-Right>", ":vertical resize +3<CR>",  { noremap = true, silent = true })

-- ── Splits ────────────────────────────────────────────────────────────────────
map("n", "<leader>sh", ":split<CR><C-w>w",  { noremap = true, desc = "Horizontal split" })
map("n", "<leader>sv", ":vsplit<CR><C-w>w", { noremap = true, desc = "Vertical split"   })

-- ── Buffers (barbar) ──────────────────────────────────────────────────────────
map("n", "<Tab>",     ":BufferNext<CR>",      { noremap = true, silent = true, desc = "Next buffer"     })
map("n", "<S-Tab>",   ":BufferPrevious<CR>",  { noremap = true, silent = true, desc = "Prev buffer"     })
map("n", "<leader>x", "<cmd>BufferClose<CR>", { noremap = true,               desc = "Close buffer"    })
map("n", "<A-p>",     ":BufferPin<CR>",       { noremap = true,               desc = "Pin buffer"      })

-- ── Escape insert ─────────────────────────────────────────────────────────────
map("i", "jk", "<ESC>", { noremap = true, desc = "Exit insert" })

-- ── Move lines in visual ──────────────────────────────────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move line up"   })

-- ── Increment / decrement ─────────────────────────────────────────────────────
map("n", "+", "<C-a>", { noremap = true })
map("n", "-", "<C-x>", { noremap = true })

-- ── Clear search highlight ────────────────────────────────────────────────────
map("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })
