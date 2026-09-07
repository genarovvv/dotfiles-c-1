return {
    {
        "rcarriga/nvim-notify",
        lazy     = false,
        priority = 900,
        config   = function()
            require("notify").setup({
                background_colour = "#0d0d0d",
                fps           = 30,
                level         = vim.log.levels.WARN,
                minimum_width = 30,
                render        = "minimal",
                stages        = "fade",
                timeout       = 2500,
                top_down      = false,
            })
            vim.notify = require("notify")
        end,
    },
}
