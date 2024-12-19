-- config for:
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/neovim/nvim-lspconfig
local leader = [[,]]

local lsp_augroup = vim.api.nvim_create_augroup('CustomLspAutocmds', { clear = true })

-- default stuff for all "lsp sessions"
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Buffer local settings for our lsp session',
    group = lsp_augroup,
    callback = function(args)
        local opts = { noremap = true, silent = true, buffer = args.bufnr }

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

        -- vim.keymap.set('n', '<C-k>', signature_help_force, opts)

        vim.keymap.set('n', leader .. 'e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', leader .. 'q', vim.diagnostic.setloclist, opts)

        vim.keymap.set('n', leader .. 'wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', leader .. 'wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', leader .. 'wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)

        vim.keymap.set('n', leader .. 'r', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', leader .. 'c', vim.lsp.buf.code_action, opts)

        vim.keymap.set('n', leader .. 'f', function()
            vim.lsp.buf.format { async = false };
        end, opts)
    end,
})

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        "williamboman/mason-lspconfig.nvim",
        'Saghen/blink.cmp',
    },
    config = function()
        -- NOTE: "mason.nvim is optimized to load as little as possible during setup. Lazy-loading the plugin, or somehow deferring the setup, is not recommended."
        require('mason').setup()

        local mason_server_list = { 'lua_ls', 'pylsp', 'texlab', 'ts_ls', 'clangd'}
        local lsp_server_list = { 'lua_ls', 'texlab', 'ts_ls', 'clangd'}
        local mason_lspconfig = require("mason-lspconfig")

        vim.lsp.set_log_level(vim.lsp.log_levels.WARN)

        -- NOTE: rust-analyzer is configured by 'rustaceanvim'. See ':h rustaceanvim.mason'
        mason_lspconfig.setup_handlers {
            ['rust_analyzer'] = function() end,
        }
        mason_lspconfig.setup {
            ensure_installed = mason_server_list,
        }

        local lsp = require('lspconfig')
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        local default_config = {
            document_highlight = {
                enabled = true,
            },
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
        }

        -- see: https://github.com/hrsh7th/nvim-cmp/issues/1129#issuecomment-1837594834
        capabilities.textDocument.completion.completionItem.snippetSupport = false

        lsp['rust_analyzer'] = function() return true end

        -- The "format on autosave" feature of Vim's Zig plugin has a bug in it:
        --      Error detected while processing BufWritePre Autocommands for "<buffer=1>"..function zig#fmt#Format:
        --      line   58:
        --      E939: Positive count required: silent! lwindow 0
        vim.g.zig_fmt_autosave = 0
        lsp['zls'].setup(vim.tbl_extend('keep', {
            cmd = {"/home/haru/.local/opt/src_active/zls/zig-out/bin/zls"},
            filetype = {"zig"},
        }, default_config))

        lsp['pylsp'].setup(vim.tbl_extend('keep', {
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = { enabled = false }
                    }
                }
            }
        }, default_config))

        for _, name in ipairs(lsp_server_list) do
            lsp[name].setup(default_config)
        end
    end,
}
