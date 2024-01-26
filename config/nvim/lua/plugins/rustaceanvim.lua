-- config for: https://github.com/mrcjkb/rustaceanvim
vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
    },
    -- LSP configuration
    server = {
        on_attach = _G.lsp_setup_sever_on_attach,
        settings = {
            ['rust-analyzer'] = {
            },
        },
    },
    -- DAP configuration
    dap = {
    },
}

return {
    {
        'mrcjkb/rustaceanvim',
        version = '^4',
        ft = 'rust',
        config = function()
        end
    },
}

