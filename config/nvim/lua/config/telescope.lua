-- config for: https://github.com/nvim-telescope/telescope.nvim
-- Also includes config for various addons/extensions.
-- See 'lua/plugins.lua' for more information... im lazy
local telescope = require 'telescope'
local themes = require 'telescope.themes'
local load_extension = telescope.load_extension

local init = function()
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


end

local map = function()
    local keymap = vim.api.nvim_set_keymap
    local keymap_options = {
        silent = true,
        noremap = true,
    }

    local file_browser_options = "{hidden=true, dir_icon = ''}"

    keymap('n', '<leader>tt', '<cmd>Telescope<CR>', keymap_options)
    keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', keymap_options)
    keymap('n', '<leader>fb', string.format("<cmd>lua require 'telescope'.extensions.file_browser.file_browser(%s)<CR>", file_browser_options), keymap_options)

end

init()
map()

