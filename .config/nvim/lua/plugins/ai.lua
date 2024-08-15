return {
    'Exafunction/codeium.vim',
    config = function ()
        vim.keymap.set('i', '<C-g><C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<C-g><C-n>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
        vim.keymap.set('i', '<C-g><C-p>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
        vim.keymap.set('i', '<C-g><C-c>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
        vim.keymap.set({'n', 'i'}, '<C-g><C-a>', "<cmd>CodeiumEnable<CR>", {noremap = true, silent = true})
        vim.g.codeium_enabled = false
        end
}
