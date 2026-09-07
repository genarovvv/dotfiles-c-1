return {
    "stevearc/dressing.nvim",
    lazy     = false,
    priority = 800,
    config   = function()
        require("dressing").setup({
            input = {
                enabled         = true,
                default_prompt  = "Input:",
                trim_prompt     = true,
                title_pos       = "center",
                insert_only     = true,
                start_in_insert = true,
                border          = "rounded",
                relative        = "editor",
                prefer_width    = 50,
                max_width       = { 140, 0.9 },
                min_width       = { 30,  0.2 },
                win_options = {
                    winblend     = 0,
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                    wrap         = false,
                },
                mappings = {
                    n = { ["<Esc>"] = "Close", ["<CR>"] = "Confirm" },
                    i = { ["<CR>"] = "Confirm", ["<C-c>"] = "Close", ["<Esc>"] = "Close" },
                },
            },
            select = {
                enabled     = true,
                backend     = { "telescope", "builtin" },
                trim_prompt = true,
            },
        })
    end,
}
