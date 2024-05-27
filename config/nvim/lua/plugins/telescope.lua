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
        local load_extension = require('telescope').load_extension
        local builtin = require('telescope.builtin')
        local extensions = require('telescope').extensions

        load_extension('fzf')
        load_extension('ui-select')

        local keymap_set = vim.keymap.set
        local keymap_options = {
            silent = true,
            noremap = true,
        }

        keymap_set('n', '<leader>ff', builtin.find_files, keymap_options)
        keymap_set('n', '<leader>fb', builtin.buffers, keymap_options)
        keymap_set('n', '<leader>fg', builtin.live_grep, keymap_options)
        keymap_set('n', '<leader>fr', builtin.registers, keymap_options)
    end,

    opts = {
        picker = {
            find_files = {
                theme = 'dropdown'
            }
        },
        extensions = {},
    }
}
