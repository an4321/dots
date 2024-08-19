return {
    {
        'stevearc/oil.nvim',
        opts = {
            vim.keymap.set('n', "<Space>e", "<cmd>Oil<CR>"),
            vim.keymap.set('n', "<Space>d", "<cmd>Oil ~/Desktop<CR>"),
            default_file_explorer = true,
            skip_confirm_for_simple_edits = true,
            delete_to_trash = true,
            trash_command = "trash-put",
            prompt_save_on_select_new_entry = true,
            keymaps = {
                ["?"] = "actions.show_help",
                ["<Cr>"] = "actions.select",
                ["<bs>"] = "actions.parent",
                ["<Right>"] = "actions.select",
                ["<Left>"] = "actions.parent",
                ["<Tab>"] = "actions.preview",
            },
            use_default_keymaps = true,
            view_options = {
                show_hidden = true,
            },
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        event = "VeryLazy",
        branch = '0.1.x',
        config = function()
            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = { "node_modules" },
                },
            }
        end,
        opts = {
            vim.keymap.set('n', '<Space>b', "<cmd>Telescope buffers<CR>"),
            vim.keymap.set('n', '<Space><Space>', "<cmd>Telescope find_files hidden=true<CR>", { desc = 'Find Files' }),
            vim.keymap.set('n', '<Space>ff', "<cmd>Telescope find_files<CR>", { desc = 'Find Files' }),
            vim.keymap.set('n', '<Space>fr', "<cmd>Telescope oldfiles<CR>", { desc = 'Recient Files' }),
            vim.keymap.set('n', '<Space>fw', "<cmd>Telescope live_grep<CR>", { desc = 'Grep Search' }),
            vim.keymap.set('n', '<Space>fd', "<cmd>Telescope diagnostics<CR>", { desc = 'Diagnostics' }),
            vim.keymap.set('n', '<Space>fc', "<cmd>Telescope colorscheme<CR>", { desc = 'Color Scheme' }),
            vim.keymap.set('n', '<Space>fs', "<cmd>Telescope spell_suggest<CR>", { desc = 'Spell' }),
            vim.keymap.set('n', '<Space>fh', "<cmd>Telescope command_history<CR>", { desc = 'Command History' }),
            vim.keymap.set('n', '<Space>.',
                "<cmd>lua require('telescope.builtin').find_files({ cwd = '~/Dots', hidden = true })<Cr>",
                { desc = 'Dot files' }),
        }
    },
    {
        'ThePrimeagen/harpoon',
        event = "VeryLazy",
        setup = {
            vim.keymap.set('n', "<Space>m", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
                { desc = 'Harpoon Menu' }),
            vim.keymap.set('n', "<Space>a", '<cmd>lua require("harpoon.mark").add_file()<CR>',
                { desc = 'Harpoon Mark' }),
            vim.keymap.set('n', "<Space>1", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>',
                { desc = 'Harpoon Mark 1' }),
            vim.keymap.set('n', "<Space>2", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>',
                { desc = 'Harpoon Mark 2' }),
            vim.keymap.set('n', "<Space>3", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>',
                { desc = 'Harpoon Mark 3' }),
            vim.keymap.set('n', "<Space>4", '<cmd>lua require("harpoon.ui").nav_file(4)<CR>',
                { desc = 'Harpoon Mark 4' }),
        },
    },
}
