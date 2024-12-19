-- config for: https://github.com/nvim-telescope/telescope.nvim
-- Also includes config for various addons/extensions.
-- See 'lua/plugins.lua' for more information
return {
    'nvim-telescope/telescope.nvim',
    event = 'BufEnter',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'nvim-telescope/telescope-ui-select.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local tscope = require('telescope')
        tscope.setup({
            defaults = {
                theme = 'ivy',
                preview = {
                    treesitter = 'true',
                },
                mappings = {
                    i = {
                        ['<C-j>'] = function()
                            -- FIXME: Find a pure lua solution...
                            vim.cmd [[stopinsert]]
                        end,
                    },
                    n = {
                        ['<C-j>'] = 'close'
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    overwrite_generic_sorter = true,
                    overwrite_file_sorter = true,
                    case_mode = 'smart_case',
                    theme = 'ivy',
                },
            },
            picker = {
                find_files = {
                    theme = 'ivy',
                },
            },
        })

        tscope.load_extension('fzf')
        tscope.load_extension('ui-select')

        local keymap_options = {
            silent = true,
            noremap = true,
        }

        local builtin = require('telescope.builtin')
        local themes = require('telescope.themes')

        vim.keymap.set('n', '<leader>f', function()
            builtin.find_files(themes.get_ivy({
                previewer = false,
            }))
        end, keymap_options)
        vim.keymap.set('n', '<leader>/', function()
            builtin.live_grep(themes.get_ivy({
                previewer = true,
            }))
        end, keymap_options)
        vim.keymap.set('n', '<leader>g', function()
            builtin.live_grep(themes.get_ivy({}))
        end, keymap_options)
        vim.keymap.set('n', '<leader>r', builtin.registers, keymap_options)
    end,

    opts = {
    }
}
