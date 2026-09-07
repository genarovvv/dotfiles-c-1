return {
    "nvim-telescope/telescope.nvim",
    cmd          = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-ui-select.nvim",
    },
    keys = {
        { "<C-p>",      function() require("telescope.builtin").find_files() end,            desc = "Buscar archivos"  },
        { "<leader>b",  function() require("telescope.builtin").buffers() end,               desc = "Buffers"          },
        { "<leader>ff", function() require("telescope.builtin").find_files() end,            desc = "Buscar archivos"  },
        { "<leader>fg", function() require("telescope.builtin").live_grep() end,             desc = "Buscar en proyecto" },
        { "<leader>fh", function() require("telescope.builtin").help_tags() end,             desc = "Ayuda"            },
        { "<leader>fr", function() require("telescope.builtin").oldfiles() end,              desc = "Recientes"        },
        { "<leader>fs", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Simbolos"         },
        { "<leader>fd", function() require("telescope.builtin").diagnostics() end,           desc = "Diagnosticos"     },
        { "<leader>gc", function() require("telescope.builtin").git_commits() end,           desc = "Git commits"      },
        { "<leader>gb", function() require("telescope.builtin").git_branches() end,          desc = "Git branches"     },
        { "<leader>gs", function() require("telescope.builtin").git_status() end,            desc = "Git status"       },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                prompt_prefix        = "   ",
                selection_caret      = "  ",
                path_display         = { "truncate" },
                file_ignore_patterns = { ".git/", "node_modules", "__pycache__" },
            },
            extensions = {
                ["ui-select"] = { require("telescope.themes").get_dropdown() },
            },
        })
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
    end,
}
