local lsp_zero = require('lsp-zero')

local lsp_attach = function(client, bufnr)
    local opts = { buffer = bufnr }

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<Space>=', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<Space>kf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<Space>kr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', '<Space>ka', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', '<Space>kd', '<cmd>lua vim.diagnostic.disable()<cr>', opts)
    vim.keymap.set('n', '<Space>kD', '<cmd>lua vim.diagnostic.enable()<cr>', opts)
end

lsp_zero.extend_lspconfig({
    sign_text = true,
    lsp_attach = lsp_attach,
    float_border = 'rounded',
    capabilities = require('cmp_nvim_lsp').default_capabilities()
})

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

-- this is the function that loads the extra snippets
-- from rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- confirm completion item
        ['<Enter>'] = cmp.mapping.confirm({ select = true }),

        -- trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- scroll up and down the documentation window
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        -- navigate between snippet placeholders
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }),
    -- note: if you are going to use lsp-kind (another plugin)
    -- replace the line below with the function from lsp-kind
    formatting = lsp_zero.cmp_format({ details = true }),
})


-- toggle format on save
-- create an autocommand group for LSP formatting
local lsp_format_group = vim.api.nvim_create_augroup("LspFormat", { clear = true })

local format_enabled_buffers = {}

local function toggle_format_on_save()
    local bufnr = vim.api.nvim_get_current_buf()
    
    if format_enabled_buffers[bufnr] then
        format_enabled_buffers[bufnr] = nil
        -- remove existing autocmd for this buffer
        vim.api.nvim_clear_autocmds({
            group = lsp_format_group,
            buffer = bufnr,
            event = "BufWritePre"
        })
        vim.notify("Format on save disabled for current buffer", vim.log.levels.INFO)
    else
        -- enable format on save
        format_enabled_buffers[bufnr] = true
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = lsp_format_group,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
        vim.notify("Format on save enabled for current buffer", vim.log.levels.INFO)
    end
end

vim.keymap.set('n', '<space>tf', toggle_format_on_save, { desc = "toggle format on save", noremap = true, silent = true })

-- attach LSP without automatic format-on-save
vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_format_group,
    callback = function(args)
        -- no automatic format-on-save setup here
        -- it will be enabled per-buffer using the toggle function
    end,
})
-- end toggle format on save
