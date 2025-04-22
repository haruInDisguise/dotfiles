-- config for:
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/neovim/nvim-lspconfig

---@module "lazy"
---@type LazySpec
return {
    {
        -- Disabled. Only used to source lsp presets
        "neovim/nvim-lspconfig",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        cmd = "Mason",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
        },

        opts = {
            ensure_installed = {
                "ts_ls",
                "csharp_ls",
                "pylsp",
                "texlab",
                "lua_ls",
                "zls",
                "clangd",
                "denols",
            },
            automatic_installation = false,
            handlers = nil,
        },
    }
}
