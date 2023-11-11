-- config for: https://github.com/neovim/nvim-lspconfig
local leader = [[,]]

function _G.lsp_setup_server_on_attach(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)

    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

    vim.keymap.set('n', leader .. 'e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', leader .. 'q', vim.diagnostic.setloclist, opts)

    vim.keymap.set('n', leader .. 'wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', leader .. 'wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', leader .. 'wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)

    vim.keymap.set('n', leader .. 'rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', leader .. 'ca', vim.lsp.buf.code_action, bufopts)

    vim.keymap.set('n', leader .. 'f', function()
            vim.lsp.buf.format{ async = false };
        end, bufopts)
end

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp'
    },
    config = function()
        -- NOTE: rust uses a seperate plugin: rust-tools.nvim
        -- local servers = {'pyright', 'texlab', 'tsserver', 'rust_analyzer'}
        local servers = {'pyright', 'texlab', 'tsserver', 'clangd'}
        local lsp = require 'lspconfig'

        for _, name in ipairs(servers) do
            lsp[name].setup {
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                on_attach = lsp_setup_server_on_attach,
                flags = {
                    debounce_text_changes = 150,
                },
            }
        end
    end,
}
