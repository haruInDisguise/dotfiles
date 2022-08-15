-- config for: https://github.com/nvim-telescope/telescope.nvim
-- Also includes config for various addons/extensions.
-- See 'lua/plugins.lua' for more information... im lazy
local telescope = require 'telescope'
local themes = require 'telescope.themes'
local builtin = require 'telescope.builtin'
local extensions = require 'telescope'.extensions

local load_extension = telescope.load_extension

local init = function()
    telescope.setup {
        picker = {
            find_files = {
                theme = 'dropdown'
            }
        },
        extensions = { ['file_browser'] = {
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

    -- Lazy loading cheatsheet...
    load_extension('cheatsheet')

end

local setup_mappings = function()
    local keymap = vim.keymap.set
    local keymap_options = {
        silent = true,
        noremap = true,
    }


    local func_find_files = function()
        builtin.find_files();
    end

    local func_file_browser = function()
        local options = { hidden=true, dir_icon = '' }
        extensions.file_browser.file_browser(options);
    end

    local func_buffer = function()
        local options = {sort_mru = true}
        builtin.buffers(options)
    end

    keymap('n', '<leader>ff', func_find_files, keymap_options)
    keymap('n', '<leader>fb', func_file_browser, keymap_options)
    keymap('n', '<leader>bb', func_buffer, keymap_options)

end

init()
setup_mappings()

