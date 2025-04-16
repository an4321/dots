-- Basic operations
vim.keymap.set({'n', 'v'}, ';', ':')
vim.keymap.set('n', 'U', "<cmd>redo<CR>")
vim.keymap.set('n', "<Esc>", "<cmd>noh<CR>")
vim.keymap.set({ 'n', 'v' }, "<Space>w", "<cmd>w<CR>")
vim.keymap.set({ 'n', 'v' }, "<Space>q", "<cmd>q<CR>")

-- Navigation
vim.keymap.set('n', "ge", "Gzz")
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")
vim.keymap.set('n', "<C-d>", "<C-d>zz")
vim.keymap.set('n', "<C-u>", "<C-u>zz")
vim.keymap.set({ 'n', 'v' }, 'j', "gj")
vim.keymap.set({ 'n', 'v' }, 'k', "gk")
vim.keymap.set({ 'n', 'v' }, 'L', '$')
vim.keymap.set({ 'n', 'v' }, 'H', '^')

-- Buffer navigation
vim.keymap.set('n', "<Space>x", "<cmd>bdelete<CR>")
vim.keymap.set('n', "<Space>l", "<cmd>bnext<CR>")
vim.keymap.set('n', "<Space>h", "<cmd>bprevious<CR>")
vim.keymap.set('n', "<Space><Tab>", "<cmd>enew<CR>")

-- Text manipulation
vim.keymap.set('i', '<C-BS>', '<C-w>', { noremap = true })
vim.keymap.set('i', '<C-h>', '<C-w>', { noremap = true })
vim.keymap.set('v', "<Space>p", "\"_dP")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', 'J', "mzJ`z")
vim.keymap.set('v', "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set('v', "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Window management
vim.keymap.set('n', "<Space>S", "<cmd>split ./ <CR>", { desc = "Split Horizontal" })
vim.keymap.set('n', "<Space>s", "<cmd>vsplit ./ <CR>", { desc = "Split Vertical" })
vim.keymap.set({ 'n', 'v' }, "<Space>j", "<C-w><C-w>", { noremap = true, silent = true, desc = "Switch between Splits" })

-- Toggles and modes
vim.keymap.set('n', '<Space>tw', ':lua vim.wo.wrap = not vim.wo.wrap<CR>',
    { noremap = true, silent = true, desc = "Toggle line wrap" })
vim.keymap.set('n', "<Space>ts", [[:set invspell<CR>]], { desc = "Toggle Spell Check" })
vim.keymap.set('n', '<Space>ft', ":set filetype=", { desc = 'File Type' })

-- Miscellaneous
vim.keymap.set({ 'n', 'v' }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set('n', "<Space>kr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename" })
vim.keymap.set('n', "<Space>kx", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set('n', "<Space><BS>", "<cmd>terminal<CR>", { desc = "Terminal" })
vim.keymap.set('n', "<Space><CR>", "<cmd>split | resize 14 | terminal<CR>", { desc = "Terminal Split" })
