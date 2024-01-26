-- config for: https://github.com/L3MON4D3/LuaSnip
return {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    lazy = true,
    build = 'make install_jsregexp',
    config = function()
        local plugin = require 'luasnip'

        plugin.filetype_extend("c", {"c"})
        plugin.filetype_extend("rs", {"rs"})
        plugin.filetype_extend("ts", {"ts"})
        plugin.filetype_extend("js", {"js"})
    end,
}
