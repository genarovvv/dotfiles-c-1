return {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event        = { "BufReadPre", "BufNewFile" },
    config       = function()
        require("barbar").setup({
            animation  = false,
            auto_hide  = 0,
            sidebar_filetypes = {
                ["neo-tree"] = { event = "BufWipeout" },
            },
            icons = {
                pinned = { button = "", filename = true },
            },
        })
    end,
}
