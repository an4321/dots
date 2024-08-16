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
        'phaazon/hop.nvim',
        branch = 'v2',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            vim.keymap.set({'n', 'v'}, "f", '<cmd>HopChar1<CR>', { desc = 'Hop to Char' }),
        },
    },
    {
        'Nvchad/nvim-colorizer.lua',
        event = 'VeryLazy',
        opts = {},
    },
}
