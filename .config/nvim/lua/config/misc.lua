
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

-- Jump to directory
vim.api.nvim_create_user_command('Jump', function(opts)
    local query = opts.arg or vim.fn.input('Search: ')

    local handle = io.popen('zoxide query ' .. query)
    local output = handle:read("*a")
    handle:close()

    output = output:gsub("\n$", "")

    if #output > 0 then
        vim.cmd("cd " .. output)
        vim.cmd("ex .")
    else
        vim.notify("No directory found", vim.log.levels.ERROR)
    end
end, { nargs = '?' })

vim.keymap.set("n", "<Space>z", ":Jump<CR>", { silent = true })

