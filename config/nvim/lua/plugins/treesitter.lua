return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local ok, configs = pcall(require, "nvim-treesitter.configs")
            if not ok then
                -- Primera instalacion: treesitter aun no esta disponible
                -- Se configurara automaticamente en la proxima sesion
                return
            end
            configs.setup({
                ensure_installed = {
                    "c", "cpp", "python", "bash", "lua", "rust",
                    "json", "yaml", "cmake", "make", "vim", "vimdoc", "regex",
                },
                auto_install = true,
                highlight    = { enable = true },
                indent       = { enable = true },
            })
        end,
    },
}
