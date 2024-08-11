return {
    {
        'vimwiki/vimwiki',
        vimwiki_list = {
            { syntax = "markdown", ext = ".md" }
        },
        config = function()
            vim.keymap.set({ 'n', 'v' }, "<leader>tt", "<cmd>VimwikiToggleListItem<CR>", { desc = "Toggle Task" })
            vim.keymap.set({ 'n', 'v' }, "<leader>tl", "<cmd>VimwikiRenumberAllLists<CR>",
                { desc = "Renumber All Lists" })
        end
    },
}
