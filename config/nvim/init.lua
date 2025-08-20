-- options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.breakindent = true
vim.opt.confirm = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'
vim.opt.signcolumn = 'yes'
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.history = 10000
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.winborder = 'rounded'
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)
vim.opt.nrformats = vim.opt.nrformats + { 'unsigned' }

-- keymaps
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', 'U', '<cmd>redo<cr>')
vim.keymap.set({ 'n', 'v' }, ';', ':')
vim.keymap.set({ 'n', 'v' }, 'n', 'nzzzv')
vim.keymap.set({ 'n', 'v' }, 'N', 'Nzzzv')
vim.keymap.set({ 'n', 'v' }, '<c-d>', '<c-d>zz')
vim.keymap.set({ 'n', 'v' }, '<c-u>', '<c-u>zz')
vim.keymap.set({ 'n', 'v' }, 'j', 'gj')
vim.keymap.set({ 'n', 'v' }, 'k', 'gk')
vim.keymap.set({ 'n', 'v' }, 'L', '$')
vim.keymap.set({ 'n', 'v' }, 'H', '^')
vim.keymap.set({ 'i', 'c' }, '<c-bs>', '<c-w>', { noremap = true })
vim.keymap.set({ 'i', 'c' }, '<c-h>', '<c-w>', { noremap = true })
vim.keymap.set('v', 'gp', '"_dP')
vim.keymap.set('v', '<tab>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<s-tab>', '<gv', { noremap = true, silent = true })
vim.keymap.set('n', '<space>q', '<cmd>q<cr>')
vim.keymap.set('n', '<space>w', '<cmd>w<cr>')
vim.keymap.set('n', '<space>x', '<cmd>bdelete<cr>')
vim.keymap.set('n', '<space>l', '<cmd>bnext<cr>')
vim.keymap.set('n', '<space>h', '<cmd>bprevious<cr>')
vim.keymap.set('n', '<space>s', '<cmd>vsplit ./<cr>')
vim.keymap.set('n', '<space>S', '<cmd>split ./<cr>')
vim.keymap.set({ 'n', 'v' }, '<space>j', '<c-w><c-w>')
vim.keymap.set('n', '<space>tw', ':lua vim.wo.wrap = not vim.wo.wrap<cr>')
vim.keymap.set('n', '<space>ts', [[:set invspell<cr>]])
vim.keymap.set('n', '<space>;', ':set filetype=')
vim.keymap.set('n', '<space>r', [[:%s/\<<c-r><c-w>\>/<c-r><c-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<space>a', (':cd ~/Desktop | ex .<cr>'))
vim.keymap.set('n', '<space>.', (':cd ~/dots | ex .<cr>'))
vim.keymap.set('n', '<space>n', ':cd ~/notes<cr>:e ~/notes/index.md<cr>')

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
})

-- reopen at last position
vim.cmd [[ au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]

-- terminal
vim.keymap.set('n', '<space><cr>', '<cmd>terminal<cr>')
vim.cmd [[ autocmd TermOpen * startinsert ]]
vim.keymap.set('t', '<Esc>', [[<c-\><c-n>]])

-- statusline
vim.opt.cmdheight = 0
vim.opt.laststatus = 3 -- global statusline
function recording_status()
    return vim.fn.reg_recording() ~= '' and 'recording @' .. vim.fn.reg_recording() or ''
end
vim.opt.statusline = '%#StatusLine#  %f %h%w%m%r %{%v:lua.recording_status()%} %=%l,%c %p%% '

-- packages
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{ 'windwp/nvim-autopairs', opts = {} },
	{
		'stevearc/oil.nvim',
		opts = {
			skip_confirm_for_simple_edits = true,
			delete_to_trash = true,
			keymaps = { ['<bs>'] = 'actions.parent', ['<tab>'] = 'actions.preview' },
			vim.keymap.set('n', '<space>e', '<cmd>Oil<cr>'),
		}
	},
	{
		'catppuccin/nvim', name = 'catppuccin',
		config = function()
			require('catppuccin').setup({
				flavour = 'mocha',
				transparent_background = true,
				float = { transparent = true }
			})
			vim.cmd.colorscheme 'catppuccin'
		end,
	},
	{
		'vimwiki/vimwiki',
		vimwiki_list = {{ syntax = 'markdown', ext = '.md' }},
        config = function()
            vim.keymap.set({ 'n', 'v' }, '<space>tt', '<cmd>VimwikiToggleListItem<cr>')
        end
	},
	{
		'folke/flash.nvim', event = 'VeryLazy',
        opts = { jump = { autojump = true } },
        keys = {
            { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end },
            { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end },
        },
	},
	{ 'nvim-lua/plenary.nvim' },
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').setup({
				defaults = { file_ignore_patterns = { 'node_modules/', 'vendor/', 'assets/' }}
			})
			vim.keymap.set('n', '<space>f', '<cmd>Telescope find_files<cr>')
			vim.keymap.set('n', '<space>b', '<cmd>Telescope buffers<cr>')
			vim.keymap.set('n', '<space>o', '<cmd>Telescope oldfiles<cr>')
			vim.keymap.set('n', '<space>/', '<cmd>Telescope live_grep<cr>')
		end,
	},
	{
		'NeogitOrg/neogit',
        keys = {{'<space>g', mode = 'n',  '<cmd>Neogit kind=replace<cr>'}},
	},
	{
		'lewis6991/gitsigns.nvim', event = 'VeryLazy',
		config = function()
			vim.keymap.set('n', '[g', '<cmd>Gitsigns prev_hunk<cr>')
			vim.keymap.set('n', ']g', '<cmd>Gitsigns next_hunk<cr>' )
			vim.keymap.set('n', '<space><tab>', '<cmd>Gitsigns preview_hunk<cr>' )
		end,
	},
	{ 'neovim/nvim-lspconfig' },
	{ 'williamboman/mason.nvim', opts = {} },
	{ 'williamboman/mason-lspconfig.nvim', opts = {} },
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		version = 'master',
		config = function()
			require('nvim-treesitter.configs').setup({
				auto_install = true,
				highlight = { enable = true },
			})
		end,
	},
	{
		'Saghen/blink.cmp',
		config = function()
			require('blink.cmp').setup({ fuzzy = { implementation = 'lua' }})
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			vim.lsp.config('*', { capabilities = capabilities })
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
			vim.keymap.set('n', 'gq', function() vim.lsp.buf.format({ async = true }) end)
			vim.keymap.set('n', '<space>d', vim.diagnostic.goto_next)
		end,
	},
})
