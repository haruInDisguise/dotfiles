-- config for nivm-colorizer.lua: https://github.com/norcalli/nvim-colorizer.lua
return {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    opts = {
        css = { names = true },
        c = { names = false },
        cpp = { names = false },
        rust = { names = false },
    }
}

