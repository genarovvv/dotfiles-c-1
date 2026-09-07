return {
    "stevearc/conform.nvim",
    event  = { "BufWritePre" },
    cmd    = { "ConformInfo" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                c      = { "clang_format" },
                cpp    = { "clang_format" },
                python = { "black" },
                bash   = { "shfmt" },
                sh     = { "shfmt" },
                rust   = { "rustfmt" },
                lua    = { "stylua" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })
    end,
}
