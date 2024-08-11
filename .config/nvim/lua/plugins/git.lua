return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "sindrets/diffview.nvim",
        },
        config = true,
        opts = {
            vim.keymap.set('n', '<Space>gg', '<cmd> Neogit kind=replace<CR>', { desc = 'NeoGit' })
        }
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            on_attach = function(bufnr)
                vim.keymap.set('n', '<Space>gk', require('gitsigns').prev_hunk,
                    { buffer = bufnr, desc = 'Previous Hunk' })
                vim.keymap.set('n', '<Space>gj', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Next Hunk' })
                vim.keymap.set('n', '<Space>gp', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = 'Hunk Preview' })
                vim.keymap.set('n', '<Space>gb', require('gitsigns').toggle_current_line_blame,
                    { buffer = bufnr, desc = 'Hunk Preview' })
            end,
            signs = {
                add          = { text = '│' },
                change       = { text = '│' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
        },
    },
}
