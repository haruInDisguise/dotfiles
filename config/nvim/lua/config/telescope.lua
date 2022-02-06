local telescope = require 'telescope'
local config = {}

local init = function()
    telescope.setup {
        extensions = {
            file_browser = {
                theme = 'ivy',
            };
        }
    }

    telescope.load_extension('file_browser')
end

local map = function()
    local keymap = vim.api.nvim_set_keymap
    local keymap_options = {
        silent = true,
        noremap = true,
    }

    keymap('n', '<leader>tt', '<cmd>Telescope<CR>', keymap_options)

    keymap('n', '<leader>fb', "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>", keymap_options)

end

init()
map()

