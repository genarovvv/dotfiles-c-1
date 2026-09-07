return {
    {
        "echasnovski/mini.pairs",
        version = "*",
        event   = "InsertEnter",
        config  = function() require("mini.pairs").setup() end,
    },
    {
        "echasnovski/mini.hipatterns",
        version = "*",
        event   = { "BufReadPre", "BufNewFile" },
        config  = function()
            local hp = require("mini.hipatterns")
            hp.setup({ highlighters = { hex_color = hp.gen_highlighter.hex_color() } })
        end,
    },
    {
        "echasnovski/mini.surround",
        version = "*",
        event   = { "BufReadPre", "BufNewFile" },
        config  = function() require("mini.surround").setup() end,
    },
}
