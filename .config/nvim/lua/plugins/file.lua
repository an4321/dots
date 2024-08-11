return {
    {
        'ThePrimeagen/harpoon',
        setup = {
            vim.keymap.set('n', "<Space>m", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
                { desc = 'Harpoon Menu' }),
            vim.keymap.set('n', "<Space>a", '<cmd>lua require("harpoon.mark").add_file()<CR>', { desc = 'Harpoon Mark' }),
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
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        config = function()
            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = { "node_modules" },
                },
            }
        end,
        opts = {
            vim.keymap.set('n', "<Space>b", "<cmd>Telescope buffers<CR>"),
            vim.keymap.set('n', '<Space><Space>', "<cmd>Telescope find_files<CR>", { desc = 'Find Files' }),
            vim.keymap.set('n', '<Space>ff', "<cmd>Telescope find_files<CR>", { desc = 'Find Files' }),
            vim.keymap.set('n', '<Space>fr', "<cmd>Telescope oldfiles<CR>", { desc = 'Recient Files' }),
            vim.keymap.set('n', '<Space>fw', "<cmd>Telescope live_grep<CR>", { desc = 'Grep Search' }),
            vim.keymap.set('n', '<Space>fd', "<cmd>Telescope diagnostics<CR>", { desc = 'Diagnostics' }),
            vim.keymap.set('n', '<Space>fc', "<cmd>Telescope colorscheme<CR>", { desc = 'Color Scheme' }),
            vim.keymap.set('n', '<Space>fs', "<cmd>Telescope spell_suggest<CR>", { desc = 'Spell' }),
        }
    },
    {
        'stevearc/oil.nvim',
        opts = {
            vim.keymap.set('n', "<Space>e", "<cmd>Oil<CR>"),
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
            -- Buffer-local options to use for oil buffers
            buf_options = {
                buflisted = false,
                bufhidden = "hide",
            },
            -- Window-local options to use for oil buffers
            win_options = {
                wrap = false,
                signcolumn = "no",
                cursorcolumn = false,
                foldcolumn = "0",
                spell = false,
                list = false,
                conceallevel = 3,
                concealcursor = "n",
            },
            -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
            default_file_explorer = true,
            -- Restore window options to previous values when leaving an oil buffer
            restore_win_options = true,
            -- Skip the confirmation popup for simple operations
            skip_confirm_for_simple_edits = true,
            -- Deleted files will be removed with the trash_command (below).
            delete_to_trash = true,
            -- Change this to customize the command used when deleting to trash
            trash_command = "trash-put",
            -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
            prompt_save_on_select_new_entry = true,
            -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
            -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
            -- Additionally, if it is a string that matches "actions.<name>",
            -- it will use the mapping at require("oil.actions").<name>
            -- Set to `false` to remove a keymap
            -- See :help oil-actions for a list of all available actions
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<Tab>"] = "actions.preview",
                ["X"] = "actions.close",
                ["H"] = "actions.parent",
                ["<bs>"] = "actions.parent",
                ["."] = "actions.toggle_hidden",
            },
            -- Set to false to disable all of the above keymaps
            use_default_keymaps = true,
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = false,
                -- This function defines what is considered a "hidden" file
                is_hidden_file = function(name, bufnr)
                    return vim.startswith(name, ".")
                end,
                -- This function defines what will never be shown, even when `show_hidden` is set
                is_always_hidden = function(name, bufnr)
                    return false
                end,
            },
            -- Configuration for the floating window in oil.open_float
            float = {
                -- Padding around the floating window
                padding = 10,
                max_width = 100,
                max_height = 0,
                border = "rounded",
                win_options = {
                    winblend = 10,
                },
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                override = function(conf)
                    return conf
                end,
            },
            -- Configuration for the actions floating preview window
            preview = {
                -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_width and max_width can be a single value or a list of mixed integer/float types.
                -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
                max_width = 0.1,
                -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
                min_width = { 40, 0.4 },
                -- optionally define an integer/float for the exact width of the preview window
                width = nil,
                -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_height and max_height can be a single value or a list of mixed integer/float types.
                -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
                max_height = 0.9,
                -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
                min_height = { 5, 0.1 },
                -- optionally define an integer/float for the exact height of the preview window
                height = nil,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
            },
            -- Configuration for the floating progress window
            progress = {
                max_width = 0.9,
                min_width = { 40, 0.4 },
                width = nil,
                max_height = { 10, 0.9 },
                min_height = { 5, 0.1 },
                height = nil,
                border = "rounded",
                minimized_border = "none",
                win_options = {
                    winblend = 0,
                },
            },
        }
    },
}