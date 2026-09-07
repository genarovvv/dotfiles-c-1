return {
    "lewis6991/gitsigns.nvim",
    event  = { "BufReadPre", "BufNewFile" },
    config = function()
        require("gitsigns").setup({
            signs = {
                add          = { text = "▎" },
                change       = { text = "▎" },
                delete       = { text = "▁" },
                topdelete    = { text = "▔" },
                changedelete = { text = "▎" },
            },
            on_attach = function(bufnr)
                local gs  = package.loaded.gitsigns
                local map = function(mode, l, r, opts)
                    opts        = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                map("n", "]g",           gs.next_hunk,   { desc = "Siguiente hunk" })
                map("n", "[g",           gs.prev_hunk,   { desc = "Hunk anterior"  })
                map("n", "<leader>gp",   gs.preview_hunk,{ desc = "Preview hunk"   })
                map("n", "<leader>gR",   gs.reset_hunk,  { desc = "Reset hunk"     })
                map("n", "<leader>gS",   gs.stage_hunk,  { desc = "Stage hunk"     })
                map("n", "<leader>gu",   gs.undo_stage_hunk, { desc = "Undo stage" })
                map("n", "<leader>gB",   function() gs.blame_line({ full = true }) end, { desc = "Blame linea" })
            end,
        })
    end,
}
