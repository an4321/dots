-- Editor appearance
vim.cmd.colorscheme("catppuccin-mocha")
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine", { underline = false, bg = "" })
vim.opt.laststatus = 3 -- Global Statusline
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- Editor behavior
vim.opt.confirm = true
vim.opt.linebreak = true
vim.opt.wrap = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = 'a'
vim.opt.history = 10000
vim.opt.isfname:append("@-@")

-- Window splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- File handling
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/vim-undodir"

-- Terminal settings
vim.cmd [[ autocmd TermOpen term://* setlocal nonumber norelativenumber ]]
vim.cmd [[ autocmd TermOpen * startinsert ]]
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- Re-open at last position
vim.cmd [[ au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Status Line
vim.opt.cmdheight = 0
vim.opt.statusline = table.concat({
  "  %t",               -- File name
  "%h",                 -- Help buffer flag
  " %m",                -- Modified flag
  "%r",                 -- Readonly flag
  "%=",                 -- Right-align the remaining sections
  " %-14.(%l,%c%V%)",   -- Line and column number
  " %P",                -- Percentage through the file
})
