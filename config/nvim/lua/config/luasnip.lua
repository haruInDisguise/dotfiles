-- config for: https://github.com/L3MON4D3/LuaSnip
local types = require("luasnip.util.types")
local luasnip = require("luasnip")

require('luasnip.loaders.from_vscode').lazy_load()

luasnip.filetype_extend("c", {"c"})
luasnip.filetype_extend("ts", {"ts"})
luasnip.filetype_extend("js", {"js"})

