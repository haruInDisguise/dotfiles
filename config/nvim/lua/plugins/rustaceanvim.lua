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
                dap = {
                    autoload_configurations = false,
                },
                server = {
                    capabilities = capabilities,
                    semanticTokensProvider = false,
                },
            }

        end
    },
}

