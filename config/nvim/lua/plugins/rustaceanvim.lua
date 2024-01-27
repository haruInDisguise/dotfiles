-- config for: https://github.com/mrcjkb/rustaceanvim
return {
    {
        'mrcjkb/rustaceanvim',
        version = '^4',
        ft = 'rust',
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = false

            vim.g.rustaceanvim = {
                -- Plugin configuration
                tools = {
                },
                -- LSP configuration
                server = {
                    capabilities = capabilities,
                    on_attach = _G.lsp_setup_server_on_attach,
                },
                -- DAP configuration
                dap = {
                },
            }

        end
    },
}

