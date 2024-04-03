vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-----------------
--     LAZY    --
-----------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    { 'catppuccin/nvim', name = "catppuccin", priority = 1000 },
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        config = function()
            require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    },
    { 'Nvchad/nvim-colorizer.lua' },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    },
    { 'folke/which-key.nvim', opts = {} },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Previous Hunk' })
                vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Next Hunk' })
                vim.keymap.set('n', '<leader>G', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Hunk Preview' })
            end,
        },
    },
    { 'vimwiki/vimwiki' },
    { 'nvim-lualine/lualine.nvim'},
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { 'numToStr/Comment.nvim', opts = {} },
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    {'nvim-tree/nvim-web-devicons'},
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    {'RRethy/vim-illuminate'},
    {'stevearc/oil.nvim', opts = {}},
    {'ThePrimeagen/harpoon'},
    {'neoclide/coc.nvim'}
}, {})

-- Colorizer
require("colorizer").setup {
    filetypes = { "*" },
    user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        mode = "background",
        tailwind = "both", -- false true "normal" "lsp" "both"
        sass = { enable = true, parsers = { "css" }, },
        always_update = false -- update even if buffer is not focused
    },
    buftypes = {},
}

vim.g.vimwiki_list = {
    {
        path = "~/vimwiki/",
        syntax = "markdown",
        ext = ".md"
    }
}

------------------
--    OPTIONS   --
------------------
vim.opt.confirm = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.linebreak = true

-- vim.api.nvim_set_hl(0, "CursorLine", {underline = false, bg = "#2e2e2e"})
vim.api.nvim_set_hl(0, "CursorLine", {underline = false})
vim.opt.cursorline = true
vim.opt.laststatus=3 -- Global Statuslin

vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.api.nvim_set_keymap('v', "<Tab>", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', "<S-Tab>", "<gv", { noremap = true, silent = true })

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 12
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

vim.opt.completeopt = 'menuone,noselect'
vim.opt.mouse = 'a'

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.completeopt = 'menuone,noselect'
vim.opt.termguicolors = true
vim.opt.history = 10000

-- Disable line numbers in terminals
vim.cmd [[ autocmd TermOpen term://* setlocal nonumber norelativenumber ]]
-- Open terminals in normal mode 
vim.cmd[[ autocmd TermOpen * startinsert ]]
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

-- Open Conf as filetype Bash
vim.cmd('autocmd BufRead * lua SetFileType()')
function SetFileType()
    local filename = vim.api.nvim_buf_get_name(0)
    local extension = filename:match('%.(%w+)$')
    if extension == 'conf' then
        vim.cmd('set filetype=bash')
    end
end

------------------
--    KEYMAPS   --
------------------
vim.api.nvim_del_keymap('n', "<leader>ww")
vim.keymap.set({'n','v'}, "<leader>tt", "<cmd>VimwikiToggleListItem<CR>", {desc = "Toggle Task"})
vim.keymap.set('n', "f", "<cmd>HopChar2<CR>", {desc = "Split Horizontal"})

vim.keymap.set({'n','v'}, "<Space>", "<Nop>", { silent = true })
vim.keymap.set('n', "<leader>e", "<cmd>Oil<CR>")

vim.keymap.set('n', "j", [[line('.')==line('$') ? 'gg' : 'j']], {expr = true, noremap = true})
vim.keymap.set('n', "k", [[line('.')==1 ? 'Gzz' : 'k']], {expr = true, noremap = true})
vim.keymap.set('n', "ge", "Gzz")
vim.keymap.set('n', "<Esc>", "<cmd>noh<CR>")
vim.keymap.set('n', "<Tab>", "zA")
vim.keymap.set('n', "U", "<cmd>redo<CR>")

vim.keymap.set({'n','v'}, "<leader>wq", "<cmd>wq<CR>")
vim.keymap.set({'n','v'}, "<leader>w", "<cmd>w<CR>")
vim.keymap.set({'n','v'}, "<leader>WW", "<cmd>:w !sudo tee %<CR>")
vim.keymap.set({'n','v'}, "<leader>q", "<cmd>q<CR>")
vim.keymap.set({'n','v','i','t'}, "<M-q>", "<cmd>q<CR>")

vim.keymap.set('n', "<leader>l", "<cmd>bnext<CR>")
vim.keymap.set('n', "<leader>h", "<cmd>bprevious<CR>")
vim.keymap.set('n', "<leader>x", "<cmd>bdelete<CR>")
vim.keymap.set('n', "<S-x>", "<cmd>bdelete<CR>")

vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('n', "J", "mzJ`z")
vim.keymap.set('n', "<C-d>", "<C-d>zz")
vim.keymap.set('n', "<C-u>", "<C-u>zz")
vim.keymap.set('n', "n", "nzzzv")
vim.keymap.set('n', "N", "Nzzzv")

vim.keymap.set('n', "<leader>F", function()
    vim.lsp.buf.format()
    print("󰉢  Buffer Formatted...")
end, {desc = "Format"})

vim.keymap.set('n', "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "Rename"})
vim.keymap.set('n', "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set('v', "<leader>c", "<cmd>'<,'>! capitalize @@<CR>", { silent = true })

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.keymap.set('n', "<leader>S", "<cmd>split ./ <CR>", {desc = "Split Horizontal"})
vim.keymap.set('n', "<leader>s", "<cmd>vsplit ./ <CR>", {desc = "Split Vertical"})
vim.keymap.set('n', "<leader><CR>", "<cmd>split  | resize 14      | terminal<CR>", {desc = 'Terminal'})
vim.keymap.set({'n','t','v'}, "<leader>j", "<C-w><C-w>", { noremap = true, silent = true, desc = "Switch between Splits"})
vim.keymap.set({'n','t','v'}, "<M-;>", "<C-\\><C-N><C-w><C-w>", { noremap = true, silent = true, desc = "Switch between Splits"})

vim.keymap.set('n', '<leader>tw', ':lua vim.wo.wrap = not vim.wo.wrap<CR>', {noremap = true, silent = true, desc = "Toggle line wrap"})
vim.keymap.set('n', "<leader>ts", [[:set invspell<CR>]], {desc = "Toggle Spell Check"})
vim.keymap.set('n', "<leader>ti", "<cmd>set foldmethod=indent<CR>", {desc = "Set Indent folds"})
vim.keymap.set('n', "<leader>tm", "<cmd>set foldmethod=manual<CR>", {desc = "Set Manual folds"})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Harpoon
vim.keymap.set('n', ";j", '<cmd>lua require("harpoon.mark").add_file()<CR>', {desc = 'Harpoon Mark'})
vim.keymap.set('n', ";m", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', {desc = 'Harpoon Menu'})
vim.keymap.set('n', ";a", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', {desc = 'Harpoon Mark 1'})
vim.keymap.set('n', ";s", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', {desc = 'Harpoon Mark 2'})
vim.keymap.set('n', ";d", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', {desc = 'Harpoon Mark 3'})
vim.keymap.set('n', ";f", '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', {desc = 'Harpoon Mark 4'})
vim.keymap.set('n', ";h", '<cmd>lua require("harpoon.ui").nav_next()<CR>', {desc = 'Harpoon Next'})
vim.keymap.set('n', ";l", '<cmd>lua require("harpoon.ui").nav_prev()<CR>', {desc = 'Harpoon Previous'})


