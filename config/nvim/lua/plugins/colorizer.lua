-- config for: https://github.com/norcalli/nvim-colorizer.lua
return {
    'NvChad/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = function()
        local colorizer = require 'colorizer'
        colorizer.setup({
            filetypes = { "c", "html", "css", "rust", "norg" },
            user_default_options = {
                names = false,
                AARRGGBB = true,
                RRGGBBAA = true,
            },
        })
    end,
}

