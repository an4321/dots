require("config.lazy")
require("config.lsp")
require("config.options")
require("config.keymaps")
require("config.misc")

-- vim.keymap.set({ 'n', 'v', 't' }, '<A-t>', '<cmd>tabnew<CR>', { noremap = true, silent = true })
-- vim.keymap.set({ 'n', 'v', 't' }, '<A-h>', '<cmd>tabprevious<CR>', { noremap = true, silent = true })
-- vim.keymap.set({ 'n', 'v', 't' }, '<A-l>', '<cmd>tabnext<CR>', { noremap = true, silent = true })
-- for i = 1, 9 do
--     vim.api.nvim_set_keymap('n', '<A-' .. tostring(i) .. '>', ':tabnext ' .. tostring(i) .. '<CR>',
--         { noremap = true, silent = true })
-- end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})
