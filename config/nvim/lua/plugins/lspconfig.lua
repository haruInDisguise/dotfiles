-- config for:
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/neovim/nvim-lspconfig
local leader = [[,]]

-- default stuff for all "lsp sessions"
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Default keybindings for Lsp sessions",
    callback = function(args)
        local opts = { noremap=true, silent=true, buffer=args.bufnr }

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

        vim.keymap.set('n', leader .. 'e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', leader .. 'q', vim.diagnostic.setloclist, opts)

        vim.keymap.set('n', leader .. 'wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', leader .. 'wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', leader .. 'wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)

        vim.keymap.set('n', leader .. 'rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', leader .. 'ca', vim.lsp.buf.code_action, opts)

        vim.keymap.set('n', leader .. 'f', function()
                vim.lsp.buf.format{ async = false };
            end, opts)
    end,
})


return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        "williamboman/mason-lspconfig.nvim",
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        -- NOTE: "mason.nvim is optimized to load as little as possible during setup. Lazy-loading the plugin, or somehow deferring the setup, is not recommended."
        require('mason').setup()

        -- FIXME: clangd is included in Archs 'clang' package. Decide which version to use
        local servers = {'pyright', 'texlab', 'tsserver', 'clangd', 'zls'}
        local mason_lspconfig = require("mason-lspconfig")

        -- NOTE: rust-analyzer is configured by 'rustaceanvim'. See ':h rustaceanvim.mason'
        mason_lspconfig.setup_handlers {
            ['rust_analyzer'] = function() end,
        }
        mason_lspconfig.setup {
            ensure_installed = servers,
        }

        local lsp = require('lspconfig')
        lsp['rust_analyzer'] = function() return true end

        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        -- see: https://github.com/hrsh7th/nvim-cmp/issues/1129#issuecomment-1837594834
        capabilities.textDocument.completion.completionItem.snippetSupport = false
        for _, name in ipairs(servers) do
            lsp[name].setup {
                capabilities = capabilities,
                on_attach = lsp_setup_server_on_attach,
                flags = {
                    debounce_text_changes = 150,
                },
            }
        end
    end,
}
