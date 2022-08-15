-- config for: https://github.com/neovim/nvim-lspconfig
-- TODO Achieve independence tm? And maybe use block comments...

-- Config taken and modified from: https://github.com/neovim/nvim-lspconfig#keybindings-and-completion

local lsp = require 'lspconfig'
local cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local default_servers = {'pyright', 'texlab', 'denols', 'tsserver'}

local function lsp_format()
    vim.lsp.buf.format {
        formatting_options = {'tabSize: 4'},
        async = false,
    };
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- TODO: Global to allow for easy plugin integration. Change this?
function lsp_server_on_attach_default(client, bufnr)
    -- Mappings
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    local leader = ','

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', leader .. 'wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', leader .. 'wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', leader .. 'wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
    vim.keymap.set('n', leader .. 'D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', leader .. 'rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', leader .. 'ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', leader .. 'f', lsp_format, bufopts)
end

-- rust uses the 'rust-tools' plugin
for _, name in ipairs(default_servers) do
    lsp[name].setup {
        capabilities = cmp_capabilities,
        on_attach = lsp_server_on_attach_default,
    }
end

lsp['clangd'].setup {
    capabilities = cmp_capabilities,
    on_attach = lsp_server_on_attach_default,
    --cmd = {'clangd', '--enable-config'},
}
