-- config for:
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/neovim/nvim-lspconfig

---@module "lazy"
---@type LazySpec
return {
    {
        -- Let lazy manage lspconfigs presets
        "neovim/nvim-lspconfig",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
        },

        cmd = "Mason",
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
