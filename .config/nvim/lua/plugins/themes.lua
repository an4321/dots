return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            transparent_background = true,
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin-mocha")
            vim.api.nvim_set_hl(0, "CursorLine", { underline = false, bg = "" })
        end,
    },
    { "ellisonleao/gruvbox.nvim" },
    { "joshdick/onedark.vim" },
    { "folke/tokyonight.nvim" },
    { "rose-pine/neovim", name = "rose-pine" },
}
