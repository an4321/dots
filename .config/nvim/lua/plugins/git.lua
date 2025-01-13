return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "sindrets/diffview.nvim",
        },
        config = true,
        keys = {
            {'<Space>gg', '<cmd> Neogit kind=replace<CR>', desc = 'NeoGit'},
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = "VeryLazy",
        opts = {
            on_attach = function(bufnr)
                vim.keymap.set('n', '<Space>gk', require('gitsigns').prev_hunk,
                    { buffer = bufnr, desc = 'Previous Hunk' })
                vim.keymap.set('n', '<Space>gj', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Next Hunk' })
                vim.keymap.set('n', '<Space>gh', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = 'Hunk Preview' })
                vim.keymap.set('n', '<Space>gb', require('gitsigns').toggle_current_line_blame,
                    { buffer = bufnr, desc = 'Hunk Preview' })
            end,
        },
    },
}
