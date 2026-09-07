return {
    "folke/which-key.nvim",
    event  = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.setup({ delay = 400, icons = { mappings = vim.g.have_nerd_font } })
        wk.add({
            { "<leader>f", group = "Buscar"  },
            { "<leader>g", group = "Git"     },
            { "<leader>d", group = "Debug"   },
            { "<leader>s", group = "Split"   },
        })
    end,
}
