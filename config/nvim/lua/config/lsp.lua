-- config for: https://github.com/neovim/nvim-lspconfig
-- TODO Achieve independence tm? And maybe use block comments...

-- Config taken and modified from: https://github.com/neovim/nvim-lspconfig#keybindings-and-completion

local lsp = require 'lspconfig'
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities();

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- TODO: Global to allow for easy plugin integration. Change this?
function lsp_setup_server_on_attach(client, bufnr)
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
    vim.keymap.set('n', leader .. 'd', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', leader .. 'rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', leader .. 'ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', leader .. 'f', function()
            --vim.lsp.buf.format{ async = false };
            vim.lsp.buf.formatting();
        end, bufopts)
end

local clangd_overwrite = "/home/haru/.local/src/clangd_15.0.1/bin/clangd"
lsp['clangd'].setup {
    capabilities = cmp_capabilities,
    on_attach = function()
        lsp_setup_server_on_attach()
        print("Using binary: " .. clangd_overwrite)
    end,
    cmd = {clangd_overwrite},
    flags = {
        debounce_text_changes = 150,
    },
}

-- Configuring lsp using passed through config
-- NOTE: rust   uses a seperate plugin: rust-tools.nvim
local servers = {'pyright', 'texlab', 'tsserver', 'rust_analyzer'}

for _, name in ipairs(servers) do
    lsp[name].setup {
        capabilities = cmp_capabilities,
        on_attach = lsp_setup_server_on_attach,
        flags = {
            debounce_text_changes = 150,
        },
    }
end

-- show line diagnostic that exceeds the line width
-- in a hover window?

