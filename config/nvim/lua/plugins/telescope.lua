-- config for: https://github.com/nvim-telescope/telescope.nvim
-- Also includes config for various addons/extensions.
-- See 'lua/plugins.lua' for more information
return {
    'nvim-telescope/telescope.nvim',
    event = 'BufEnter',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'nvim-telescope/telescope-ui-select.nvim',

        'nvim-telescope/telescope-file-browser.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local load_extension = require('telescope').load_extension
        local builtin = require('telescope.builtin')
        local extensions = require('telescope').extensions

        load_extension('fzf')
        load_extension('file_browser')
        load_extension('ui-select')

        -- Lazy loading cheatsheet...
        -- load_extension('cheatsheet')

        local keymap = vim.keymap.set
        local keymap_options = {
            silent = true,
            noremap = true,
        }

        keymap('n', '<leader>ff', builtin.find_files, keymap_options)
        keymap('n', '<leader>fg', builtin.live_grep, keymap_options)
        keymap('n', '<leader>fr', builtin.registers, keymap_options)
        keymap('n', '<leader>fb', function()
            extensions.file_browser.file_browser({
                hidden=true,
                dir_icon = ''
            })
        end, keymap_options)
    end,

    opts = {
        picker = {
            find_files = {
                theme = 'dropdown'
            }
        },
        extensions = {
            ['file_browser'] = {
                theme = 'ivy',
            },
            ['fzf'] = {
                -- fuzzy = true,
                -- override_generic_sorter = true,
                -- override_file_sorter = true,
                -- case_mode = 'smart_case',
            },
            ['ui-select'] = {}
        },
    }
}
