return {
    "saghen/blink.cmp",
    event        = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "rafamadriz/friendly-snippets",
        "L3MON4D3/LuaSnip",
    },
    version = "1.*",
    config  = function()
        local luasnip = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load({
            paths = vim.fn.stdpath("config") .. "/snippets",
        })

        require("blink.cmp").setup({
            keymap = {
                preset    = "enter",
                ["<Tab>"]   = { "select_next",  "snippet_forward",  "fallback" },
                ["<S-Tab>"] = { "select_prev",  "snippet_backward", "fallback" },
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
                ghost_text    = { enabled = true },
                menu          = { draw = { treesitter = { "lsp" } } },
            },
            snippets = { preset = "luasnip" },
            fuzzy    = { implementation = "prefer_rust_with_warning" },
        })
    end,
}
