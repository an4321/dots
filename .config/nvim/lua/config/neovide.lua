
if vim.g.neovide then
    vim.g.neovide_transparency = 0.9
    vim.o.guifont = "JetBrainsMono Nerd Font:h16"
    vim.g.neovide_hide_mouse_when_typing = true
    vim.cmd("hi! Normal guibg=#262626 ctermbg=NONE")
    vim.cmd("hi! NonText guibg=NONE ctermbg=NONE")
end
