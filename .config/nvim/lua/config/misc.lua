
vim.opt.cmdheight = 0
function recording_status()
    local recording = vim.fn.reg_recording()
    if recording ~= "" then
        return "recording @" .. recording
    else
        return ""
    end
end

vim.opt.statusline = '%#StatusLine#  %f %h%w%m%r %{%v:lua.recording_status()%} %=%l,%c %p%% '

-- Terminal
vim.cmd [[ autocmd TermOpen term://* setlocal nonumber norelativenumber ]]
vim.cmd [[ autocmd TermOpen * startinsert ]]
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- NeoVide
if vim.g.neovide then
    vim.g.neovide_transparency = 0.9
    vim.o.guifont = "JetBrainsMono Nerd Font:h16"
    vim.g.neovide_hide_mouse_when_typing = true
    vim.cmd("hi! Normal guibg=#262626 ctermbg=NONE")
    vim.cmd("hi! NonText guibg=NONE ctermbg=NONE")
    vim.keymap.set({ 'n', 'v', 'i', 't' }, "<M-q>", "<cmd>bdelete<CR>")
end

