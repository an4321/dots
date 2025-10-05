for k, v in pairs({
	number = true, relativenumber = true, confirm = true, list = true,
	wrap = false, ignorecase = true, smartcase = true, undofile = true,
	autoindent = true, smartindent = true, splitright = true, splitbelow = true,
	swapfile = false, backup = false, scrolloff = 15, history = 10000,
	tabstop = 4, shiftwidth = 4, cmdheight = 0, laststatus = 3,
	inccommand = "split", signcolumn = "yes", winborder = "rounded",
}) do vim.opt[k] = v end

vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)
vim.opt.nrformats = vim.opt.nrformats + { 'unsigned' }

vim.keymap.set('n', '<esc>', ':nohlsearch<cr>')
vim.keymap.set('n', 'U', ':redo<cr>')
vim.keymap.set({ 'n', 'v' }, ';', ':')
vim.keymap.set({ 'n', 'v' }, 'L', '$')
vim.keymap.set({ 'n', 'v' }, 'H', '^')
vim.keymap.set({ 'i', 'c' }, '<c-bs>', '<c-w>', { noremap = true })
vim.keymap.set({ 'i', 'c' }, '<c-h>', '<c-w>', { noremap = true })
vim.keymap.set('v', 'gp', '"_dP')
vim.keymap.set('v', '<tab>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<s-tab>', '<gv', { noremap = true, silent = true })
vim.keymap.set('n', '<space>q', ':quit<cr>')
vim.keymap.set('n', '<space>w', ':update<cr>')
vim.keymap.set('n', '<space>x', ':bdelete<cr>')
vim.keymap.set('n', '<space>l', ':bnext<cr>')
vim.keymap.set('n', '<space>h', ':bprevious<cr>')
vim.keymap.set('n', '<space>j', '<c-w><c-w>')
vim.keymap.set('n', '<space>tw', ':set wrap!<cr>')
vim.keymap.set('n', '<space>ts', ':set spell!<cr>')
vim.keymap.set('n', '-', '1z=')
vim.keymap.set('n', '?', ':%s/')
vim.keymap.set('n', '<space>r', [[:%s/\<<c-r><c-w>\>/<c-r><c-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<bs>', ':term ')
vim.keymap.set('t', '<c-c>', [[<c-\><c-n>]])

-- highlight on yank
vim.cmd [[ autocmd TextYankPost * lua vim.hl.on_yank() ]]
-- reopen at last position
vim.cmd [[ au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]
-- terminal start in insert mode
vim.cmd [[ autocmd TermOpen * startinsert ]]

-- statusline
require('vim._extui').enable({}) -- temp
function recording_status()
	return vim.fn.reg_recording() ~= '' and 'recording @' .. vim.fn.reg_recording() or ''
end
vim.opt.statusline = '%#StatusLine#  %f %h%w%m%r %{%v:lua.recording_status()%} %=%l,%c %p%% '

-- packages
vim.pack.add({
	'https://github.com/catppuccin/nvim',
	'https://github.com/stevearc/oil.nvim',
	'https://github.com/nvim-mini/mini.pairs',
	'https://github.com/folke/flash.nvim',
	'https://github.com/ibhagwan/fzf-lua',
	'https://github.com/lewis6991/gitsigns.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },
	'https://github.com/Saghen/blink.cmp',
})

require('catppuccin').setup({
	transparent_background = true, float = { transparent = true }
})
vim.cmd.colorscheme 'catppuccin-mocha'
vim.schedule(function()
	require('oil').setup({
		skip_confirm_for_simple_edits = true, delete_to_trash = true,
		keymaps = { ['<bs>'] = 'actions.parent', ['<tab>'] = 'actions.preview' }
	})
	require('flash').setup({ jump = { autojump = true }})
	require('mini.pairs').setup()
	require('gitsigns')
	require('mason').setup()
	require('mason-lspconfig').setup()
	require('nvim-treesitter.configs').setup({
		auto_install = true, highlight = { enable = true }
	})
	require('blink.cmp').setup({ fuzzy = { implementation = 'lua' }})
	local capabilities = require('blink.cmp').get_lsp_capabilities()
	vim.lsp.config('*', { capabilities = capabilities })
end)

vim.keymap.set('n', '<space>e', ':Oil<cr>')
vim.keymap.set('n', 's', function() require('flash').jump() end)
vim.keymap.set('n', '<space>f', ':FzfLua files<cr>')
vim.keymap.set('n', '<space>b', ':FzfLua buffers<cr>')
vim.keymap.set('n', '<space>o', ':FzfLua oldfiles<cr>')
vim.keymap.set('n', '<space>/', ':FzfLua live_grep<cr>')
vim.keymap.set('n', '<space>.', ':cd ~/dots | FzfLua files<cr>')
vim.keymap.set('n', '<space><tab>', ':Gitsigns preview_hunk<cr>')
vim.keymap.set('n', '[g', ':Gitsigns prev_hunk<cr>')
vim.keymap.set('n', ']g', ':Gitsigns next_hunk<cr>')
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gq', function() vim.lsp.buf.format({ async = true }) end)
vim.keymap.set('n', '<space>d', function() vim.diagnostic.jump({count = 1, float = true}) end)

