-- config for: https://github.com/hrsh7th/nvim-cmp
return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'onsails/lspkind.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function(_, opts)
        require('cmp').setup(opts)
    end,
    opts = function(_, opts)
        local cmp = require('cmp')
        local window_style = _G.default_config.window_style;

        return {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(asnicwprgs.body, {
                        -- default behaviour
                        jump_into_func = function(snip)
                            return snip:jump_into(1)
                        end,
                    })
                end,
            },
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'nvim_lsp' },
            }),
            view = {
                entries = {
                    name = "custom",
                    selection_order = "near_cursor",
                }
            },
            window = {
                documentation = vim.tbl_extend("force", window_style, {}),
                completion = vim.tbl_extend("force", window_style, {}),
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
