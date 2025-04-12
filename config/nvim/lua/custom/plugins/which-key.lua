-- config for: https://github.com/folke/which-key.nvim

---@module 'lazy'
---@type LazyPluginSpec
return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    ---@module 'which-key'
    ---@type wk.Opts
    opts = {
        delay = 300,
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
