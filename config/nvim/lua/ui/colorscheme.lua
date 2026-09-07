return {
    {
        "folke/tokyonight.nvim",
        lazy     = false,
        priority = 1000,
        config   = function()
            require("tokyonight").setup({
                style       = "night",
                transparent = true,
                styles = {
                    sidebars  = "dark",
                    floats    = "dark",
                    comments  = { italic = true },
                    keywords  = { italic = true, bold = true },
                    functions = { italic = true, bold = true },
                    variables = {},
                },
                on_highlights = function(hl, c)
                    -- Syntax mas vivo
                    hl["@keyword"]          = { fg = c.purple,  italic = true, bold = true }
                    hl["@keyword.return"]   = { fg = c.purple,  italic = true, bold = true }
                    hl["@function"]         = { fg = c.blue,    bold = true }
                    hl["@function.call"]    = { fg = c.blue }
                    hl["@method"]           = { fg = c.blue,    bold = true }
                    hl["@method.call"]      = { fg = c.blue }
                    hl["@string"]           = { fg = c.green }
                    hl["@number"]           = { fg = c.orange }
                    hl["@float"]            = { fg = c.orange }
                    hl["@boolean"]          = { fg = c.orange,  bold = true }
                    hl["@constant"]         = { fg = c.orange,  bold = true }
                    hl["@type"]             = { fg = c.cyan,    bold = true }
                    hl["@type.builtin"]     = { fg = c.cyan }
                    hl["@variable"]         = { fg = c.fg }
                    hl["@parameter"]        = { fg = c.yellow }
                    hl["@comment"]          = { fg = c.comment, italic = true }
                    hl["@include"]          = { fg = c.cyan }
                    hl["@preproc"]          = { fg = c.cyan }
                    -- Telescope
                    hl.TelescopeNormal       = { bg = "NONE" }
                    hl.TelescopeBorder       = { fg = c.blue_dark }
                    hl.TelescopePromptTitle  = { fg = c.magenta, bold = true }
                    hl.TelescopePreviewTitle = { fg = c.green,   bold = true }
                    hl.TelescopeResultsTitle = { fg = c.cyan,    bold = true }
                    hl.TelescopeMatching     = { fg = c.orange,  bold = true }
                    -- Completion
                    hl.Pmenu    = { bg = c.bg_dark }
                    hl.PmenuSel = { bg = c.bg_highlight, bold = true }
                end,
            })
            vim.cmd.colorscheme("tokyonight-night")
        end,
    },
}
