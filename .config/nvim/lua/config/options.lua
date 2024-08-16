-- Editor appearance
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
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
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.backspace = "indent,eol,start"

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

-- Re-open at last position
vim.cmd [[ au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]

