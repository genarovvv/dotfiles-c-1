return {
    {
        "williamboman/mason.nvim",
        cmd    = "Mason",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons  = {
                        package_installed   = "",
                        package_pending     = "",
                        package_uninstalled = "",
                    },
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event        = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = { "clangd", "pylsp", "bashls", "lua_ls", "rust_analyzer" },
            auto_install     = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        event        = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason-lspconfig.nvim", "saghen/blink.cmp" },
        config       = function()
            local lspconfig    = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            local on_attach = function(_, bufnr)
                vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                require("keymaps.lsp")
            end

            local servers = {
                clangd = {
                    cmd = {
                        "clangd", "--background-index", "--clang-tidy",
                        "--completion-style=detailed", "--header-insertion=never",
                    },
                },
                pylsp = {
                    settings = {
                        pylsp = {
                            plugins = {
                                pyflakes = { enabled = true  },
                                pylint   = { enabled = false },
                                black    = { enabled = true  },
                            },
                        },
                    },
                },
                bashls        = {},
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = { command = "clippy" },
                            cargo       = { allFeatures = true },
                        },
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime     = { version = "LuaJIT" },
                            workspace   = {
                                checkThirdParty = false,
                                library         = vim.api.nvim_get_runtime_file("", true),
                            },
                            diagnostics = { globals = { "vim" } },
                            telemetry   = { enable = false },
                        },
                    },
                },
            }

            for name, config in pairs(servers) do
                config.capabilities = capabilities
                config.on_attach    = on_attach
                lspconfig[name].setup(config)
            end

            vim.diagnostic.config({
                virtual_text     = false,
                signs            = true,
                underline        = true,
                update_in_insert = false,
                severity_sort    = true,
                float = { border = "rounded", source = "always", header = "", prefix = "" },
            })

            local signs = { Error = "", Warn = "", Hint = "", Info = "" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },
}
