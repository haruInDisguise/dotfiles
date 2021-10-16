local tele = require 'telescope'
local config = {}

local init = function()
    tele.setup {
        
    }
end

local map = function()
    local keymap = vim.api.nvim_set_keymap
    local keymap_options = {
        silent = true,
        noremap = true,
    }

    keymap('n', '<leader>tt', '<cmd>Telescope<CR>', keymap_options)
    keymap('n', '<leader>tf', '<cmd>Telescope find_files<CR>', keymap_options)
    keymap('n', '<leader>tf', '<cmd>Telescope find_files<CR>', keymap_options)
    keymap('n', '<leader>tf', '<cmd>Telescope find_files<CR>', keymap_options)

end

init()
map()

