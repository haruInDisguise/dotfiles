require('mason-lspconfig').setup_handlers {
    ['rust_analyzer'] = function() end,
}

local capabilities = require('blink.cmp').get_lsp_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

---@type RustaceanOpts
vim.g.rustaceanvim = {
    dap = {
        autoload_configurations = false,
    },
    server = {
        capabilities = capabilities,
        semanticTokensProvider = true,
    },
}

local opts = {
    buffer = vim.api.nvim_get_current_buf(),
    noremap = true,
    silent = true,
}


-- vim.keymap.del('n', 'J', { buffer = vim.api.nvim_get_current_buf() })
vim.keymap.set('n', 'J', function()
    vim.cmd.RustLsp('joinLines')
end, opts)
