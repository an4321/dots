return {
    { 'nvim-lua/plenary.nvim' },
    {
        'RRethy/vim-illuminate',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'windwp/nvim-autopairs',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {},
    },
    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'Nvchad/nvim-colorizer.lua',
        event = 'VeryLazy',
        opts = {},
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            jump = { autojump = true, },
        },
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
    },
}
