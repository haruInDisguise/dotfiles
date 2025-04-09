-- config for: https://github.com/stevearc/oil.nvim

---@module 'lazy'
---@type LazySpec
return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,

    -- 'VeryLazy' prevents oil from replacing netrw. In general, lazy loading is discouraged
    init = function(plugin)
        local oil = require('oil')

        vim.keymap.set("n", "<Leader>-", oil.open_float, { desc = "Open parent directory" })
        vim.keymap.set("n", "<Leader>_", oil.open, { desc = "Open parent directory" })
    end,

    ---@module 'oil'
    ---@type oil.Config
    opts = {
        default_file_explorer = true,
    },
}
