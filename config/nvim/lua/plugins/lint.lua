return {
    "mfussenegger/nvim-lint",
    event  = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            c      = { "clangtidy"  },
            cpp    = { "clangtidy"  },
            python = { "flake8"     },
            bash   = { "shellcheck" },
            sh     = { "shellcheck" },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
            callback = function() lint.try_lint() end,
        })
    end,
}
