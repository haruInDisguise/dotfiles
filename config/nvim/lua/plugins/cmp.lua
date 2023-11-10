-- config for nvim-cmp: https://github.com/hrsh7th/nvim-cmp
-- and: https://github.com/saadparwaiz1/cmp_luasnip

local cmp = require('cmp')

return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'L3MON4D3/LuaSnip',
        'onsails/lspkind.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
    },
    config = function()
        cmp.setup.cmdline('/', {
            completion = { autocomplete = false },
            sources = {
                { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } },
            }
        })

        cmp.setup.cmdline(':', {
            completion = { autocomplete = false },
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })
    end,
    opts = {
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        sources = {
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'vim-snippets'},
        },
        view = {
            entries = {
                name = "custom",
                selection_order = "near_cursor",
            }
        },
        formatting = {
            --format = require('lspkind').cmp_format({
            --    mode = 'symbol',
            --    maxwidth = 50,
            --    menu = {
            --        buffer = "[Buffer]",
            --        nvim_lsp = "[LSP]",
            --        luasnip = "[LuaSnip]",
            --        nvim_lua = "[Lua]",
            --        latex_symbols = "[Latex]",
            --        vim_snip = "[VimSnip]"
            --    },
            --}),
        },

        mapping = {
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),

            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
            ['<CR>'] = cmp.mapping.confirm({select = false}),
            ['<C-e>'] = cmp.mapping.abort(),

        },
    }
}
