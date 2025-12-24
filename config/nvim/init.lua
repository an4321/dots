vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.confirm = true
vim.opt.list = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.scrolloff = 15
vim.opt.history = 10000
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.inccommand = "split"
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.nrformats = vim.opt.nrformats + { 'unsigned' }
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)
require('vim._extui').enable({})

-- highlight on yank
vim.cmd [[ au TextYankPost * lua vim.hl.on_yank() ]]
-- reopen at last position
vim.cmd [[ au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]
-- terminal start in insert mode
vim.cmd [[ au TermOpen * startinsert ]]

-- statusline
function recording_status()
	return vim.fn.reg_recording() ~= '' and 'recording @' .. vim.fn.reg_recording() or ''
end
vim.opt.statusline = '%#StatusLine#  %f %h%w%m%r %{%v:lua.recording_status()%} %=%l,%c %p%% '

-- packages
vim.pack.add({
	'https://github.com/catppuccin/nvim',
	'https://github.com/nvim-mini/mini.files',
	'https://github.com/ibhagwan/fzf-lua',
	'https://github.com/lewis6991/gitsigns.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },
	'https://github.com/saghen/blink.cmp',
})

require('mini.files').setup({ options = { permanent_delete = false } })
require('catppuccin').setup({ transparent_background = true, float = { transparent = true } })
vim.cmd.colorscheme 'catppuccin-mocha'

vim.schedule(function()
	require('gitsigns')
	require('mason').setup()
	require('mason-lspconfig').setup()
	require('nvim-treesitter.configs').setup({ auto_install = true, highlight = { enable = true }})
	require('blink.cmp').setup({ fuzzy = { implementation = 'lua' }})
	vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })
end)

vim.keymap.set('n', '<space>f', '<cmd>lua MiniFiles.open()<cr>')
vim.keymap.set('n', '<space>a', '<cmd>FzfLua files<cr>')
vim.keymap.set('n', '<space>g', '<cmd>FzfLua live_grep<cr>')
vim.keymap.set('n', '<space>c', '<cmd>cd ~/dots | FzfLua files<cr>')
vim.keymap.set('n', '<space><tab>', '<cmd>Gitsigns preview_hunk<cr>')
vim.keymap.set('n', '[g', '<cmd>Gitsigns prev_hunk<cr>')
vim.keymap.set('n', ']g', '<cmd>Gitsigns next_hunk<cr>')
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gq', function() vim.lsp.buf.format({ async = true }) end)
vim.keymap.set('n', '<space>d', function() vim.diagnostic.jump({count = 1, float = true}) end)

for _, i in ipairs({ '()', '[]', '{}', '""', '``' }) do
	vim.keymap.set('i', i:sub(1,1), i .. '<left>')
end

vim.keymap.set({'n', 'v'}, '<c-q>', function()
	vim.cmd(#vim.fn.getbufinfo({ buflisted = 1 }) > 1 and 'bd' or 'q')
end)
vim.keymap.set({'n', 'v'}, '<c-s>', '<cmd>update<cr>')

vim.keymap.set('n', '<c-h>', '<cmd>bp<cr>')
vim.keymap.set('n', '<c-l>', '<cmd>bn<cr>')
vim.keymap.set('n', '<esc>', '<cmd>nohls<cr>')
vim.keymap.set('n', 'U', '<cmd>redo<cr>')
vim.keymap.set({ 'n', 'v' }, ';', ':')
vim.keymap.set('n', 's', ';')
vim.keymap.set({ 'n', 'v' }, 'L', '$')
vim.keymap.set({ 'n', 'v' }, 'H', '^')
vim.keymap.set({ 'i', 'c' }, '<c-bs>', '<c-w>')
vim.keymap.set({ 'i', 'c' }, '<c-h>', '<c-w>')
vim.keymap.set('v', 'gp', '"_dP')
vim.keymap.set('v', '<tab>', '>gv')
vim.keymap.set('v', '<s-tab>', '<gv')
vim.keymap.set('n', 'S', '1z=')
vim.keymap.set('n', '+', '<c-a>')
vim.keymap.set('n', '-', '<c-x>')
vim.keymap.set('v', '+', 'g<c-a>')
vim.keymap.set('v', '-', 'g<c-x>')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', '?', ':%s/')
vim.keymap.set('n', '<space>r', [[:%s/\<<c-r><c-w>\>/<c-r><c-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<bs>', ':term ')
vim.keymap.set('t', '<c-c>', [[<c-\><c-n>]])
