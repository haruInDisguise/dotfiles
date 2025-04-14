local server_list = {
    { "clangd",    require_mason = false },
    { "csharp_ls", require_mason = true },
    { "denols",    require_mason = false },
    { "lua_ls",    require_mason = true },
    { "pylsp",     require_mason = true },
    { "texlab",    require_mason = true },
    { "ts_ls",     require_mason = false },
    { "zls",       require_mason = false },
}

local on_attach = function(args)
    local leader = [[,]]
    local map_config = { noremap = true, buffer = args.buf }

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        vim.keymap.set("n", "<leader>uh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
        end, { desc = "Toggle inlay hints" })
    end

    local set_key = function(mode, lhs, rhs, config)
        vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend('keep', config, map_config))
    end

    set_key("n", "gK", function()
        local old_opts = vim.diagnostic.config()

        if not old_opts then
            return
        end

        vim.diagnostic.config({
            virtual_text = not old_opts.virtual_text or false,
            virtual_lines = not old_opts.virtual_lines or false,
        })
    end, {})

    vim.keymap.set("n", "<leader>h", vim.lsp.buf.type_definition, map_config)

    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, map_config)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, map_config)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, map_config)

    vim.keymap.set("n", leader .. "e", vim.diagnostic.open_float, map_config)
    vim.keymap.set("n", leader .. "q", vim.diagnostic.setqflist, map_config)

    vim.keymap.set("n", leader .. "wa", vim.lsp.buf.add_workspace_folder, map_config)
    vim.keymap.set("n", leader .. "wr", vim.lsp.buf.remove_workspace_folder, map_config)
    vim.keymap.set("n", leader .. "wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, map_config)

    vim.keymap.set("n", leader .. "r", vim.lsp.buf.rename, map_config)
    vim.keymap.set("n", leader .. "f", function()
        vim.lsp.buf.format { async = false };
    end, map_config)
end

-- Make sure "Mason" adds its sever binaries to PATH
require("mason")

-- Let "blink-cmp" register its own capabilities
require("blink-cmp")

local mason_servers = vim.tbl_map(function(item)
    return item.require_mason and item[1] or nil
end, server_list)

local all_servers = vim.tbl_map(function(item)
    return item[1]
end, server_list)

--- Setup default configuration for all clients
---@type vim.lsp.Config
vim.lsp.config("*", {})
vim.lsp.enable(all_servers, true)

-- local bin_targets = vim.tbl_map(function(item)
--     local bin = vim.lsp.config[item].cmd[1]
--     return bin
-- end, mason_servers)
--
-- local path = require('pathlib').stdpath("data", "mason", "bin").find("")

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "'on_attach' hook for LSP clients",
    callback = on_attach,
})
