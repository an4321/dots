return {
    { 'nvim-lua/plenary.nvim' },
    { 'RRethy/vim-illuminate' },
    { 'Nvchad/nvim-colorizer.lua' },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = { },
    },
    -- { 'nvim-tree/nvim-web-devicons' },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        opts = {
            vim.keymap.set('n', "f", "<cmd>HopChar1<CR>", { desc = "Hop to Char" })
        }
    },
}
