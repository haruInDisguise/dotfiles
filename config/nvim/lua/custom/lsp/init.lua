local utils = require("custom.utils")
local diagnostics = require('custom.lsp.diagnostics')

local server_list = {
    "clangd",
    "csharp_ls",
    "denols",
    "lua_ls",
    "pylsp",
    "texlab",
    "ts_ls",
    "zls",
}

local on_attach = function(args)
    local leader = ","
    local map_config = { noremap = true }
    local set_keymap = utils.keymap.get_func_with_config(map_config)

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        vim.keymap.set("n", leader .. "uh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
        end, { desc = "Toggle inlay hints" })
    end

    set_keymap("n", "gt", vim.lsp.buf.type_definition, { desc = "Goto type definition" })
    set_keymap("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
    set_keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })

    set_keymap("n", leader .. "wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
    set_keymap("n", leader .. "wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
    set_keymap("n", leader .. "wl", function()
        vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()), vim.log.levels.INFO)
    end, { desc = "List workspace folders" })

    set_keymap("n", leader .. "r", function()
        vim.lsp.buf.rename()
    end, { desc = "Rename the symbol under the cursor" })
    set_keymap("n", leader .. "f", function()
        vim.lsp.buf.format { async = false };
    end, { desc = "Format the buffer" })

    -- Diagnostic mappings
    set_keymap("n", leader .. "e", vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window" })
    set_keymap("n", leader .. "q", function()
        -- diagnostics.toggle_qflist()
    end, { desc = "WIP: Populate the qflist with lsp diagnostics" })

    set_keymap("n", "gK", function()
        local old_opts = vim.diagnostic.config()

        if not old_opts then
            return
        end

        vim.diagnostic.config({
            virtual_text = not old_opts.virtual_text or false,
            virtual_lines = not old_opts.virtual_lines or false,
        })
    end, { desc = "Toggle virtual lines" })
end

-- Let "blink-cmp" register its own capabilities
require("blink-cmp")

-- Register lsp servers
local mason_binaries = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_binaries .. ":" .. vim.env.PATH

-- Make sure "nvim-lspconfig/lsp" is sourced first, so
-- we can overwrite it
local lsp_templates = vim.fn.stdpath("data") .. "/lazy/nvim-lspconfig"
vim.opt.rtp:prepend(lsp_templates)

vim.lsp.enable(server_list)
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "'on_attach' hook for LSP clients",
    callback = on_attach,
})
