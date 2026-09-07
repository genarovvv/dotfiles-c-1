return {
    "nvim-neo-tree/neo-tree.nvim",
    branch       = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Explorador de archivos" },
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            window = { width = 30 },
            filesystem = {
                filtered_items = {
                    hide_dotfiles   = false,
                    hide_gitignored = false,
                },
                follow_current_file = { enabled = true },
            },
            sources         = { "filesystem", "buffers", "git_status" },
            source_selector = { winbar = true },
        })
    end,
}
