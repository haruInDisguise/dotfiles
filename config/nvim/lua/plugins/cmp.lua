-- config for nvim-cmp: https://github.com/hrsh7th/nvim-cmp
-- and: https://github.com/saadparwaiz1/cmp_luasnip

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
    config = function(_, opts)
        local cmp = require('cmp') cmp.setup(opts)
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
    opts = function(_, opts)
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        local default_win_config = {
            border = 'rounded',
            winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
            zindex = 1001,
            col_offset = 2,
            side_padding = 1,
            scrollbar = true,
        }

        return {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
            }),
            view = {
                entries = {
                    name = "custom",
                    selection_order = "near_cursor",
                }
            },
            window = {
                documentation = vim.tbl_extend("force", default_win_config, {}),
                completion = vim.tbl_extend("force", default_win_config, {}),
                },
            formatting = {
                format = function(entry, vim_item)
                    local lspkind = require('lspkind')
                    return lspkind.cmp_format({
                        maxwidth = 20,
                    })(entry, vim_item)
                end
            },
            mapping = {
                ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({behaviour = cmp.SelectBehavior.Insert}), {'i', 'c'}),
                ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({behaviour = cmp.SelectBehavior.Insert}), {'i', 'c'}),

                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),

                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
                ['<CR>'] = cmp.mapping(cmp.mapping.confirm({select = true}), {'i', 'c'}),
                ['<C-e>'] = cmp.mapping(cmp.mapping.abort(), {'i', 'c'}),
            },
        }
    end
}
