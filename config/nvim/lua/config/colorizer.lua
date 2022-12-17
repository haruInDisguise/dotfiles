-- config for nivm-colorizer.lua: https://github.com/norcalli/nvim-colorizer.lua
local colorizer = require 'colorizer'

colorizer.setup = {
    '*',
    css = { names = true },
    c = { names = false },
    cpp = { names = false },
    rust = { names = false },
}

