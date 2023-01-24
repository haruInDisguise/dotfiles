-- config for: https://github.com/nvim-telescope/telescope.nvim
-- Also includes config for various addons/extensions.
-- See 'lua/plugins.lua' for more information
local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
local themes = require 'telescope.themes'

local extensions = telescope.extensions
local load_extension = telescope.load_extension

telescope.setup {
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
        ['ui-select'] = {
            themes.get_dropdown {
                -- opts for dropdown theme
            }
        },
    },
}

load_extension('fzf')
load_extension('file_browser')
load_extension('ui-select')

load_extension('project')

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

