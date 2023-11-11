-- config for: https://github.com/L3MON4D3/LuaSnip
return {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    lazy = true,
    dependencies = { 'rafamadriz/friendly-snippets'},
    build = 'make install_jsregexp',
    config = function()
        require('luasnip.loaders.from_vscode').lazy_load()

        local plugin = require 'luasnip'

        plugin.filetype_extend("c", {"c"})
        plugin.filetype_extend("rs", {"rs"})
        plugin.filetype_extend("ts", {"ts"})
        plugin.filetype_extend("js", {"js"})
    end,
}
