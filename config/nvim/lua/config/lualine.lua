-- config for: https://github.com/hoob3rt/lualine.nvim
local lualine = require 'lualine'
local config = {}

local init = function()
    lualine.setup({
        options = {
            icons_enabled = true,
            theme = 'gruvbox-material',
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch'},
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {}
    })
end

init()

