return {
    {
        'vimwiki/vimwiki',
        vimwiki_list = {
            { syntax = "markdown", ext = ".md" }
        },
        config = function()
            vim.keymap.set({ 'n', 'v' }, "<Space>tt", "<cmd>VimwikiToggleListItem<CR>", { desc = "Toggle Task" })
            vim.keymap.set({ 'n', 'v' }, "<Space>tl", "<cmd>VimwikiRenumberAllLists<CR>",
                { desc = "Renumber All Lists" })
        end
    },
}
