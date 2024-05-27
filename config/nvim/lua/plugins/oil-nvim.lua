-- config for: https://github.com/stevearc/oil.nvim
return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- 'VeryLazy' prevents oil from replacing netrw
    event = 'VimEnter',
    config = function(_, opt)
        local oil = require('oil')
        oil.setup({
            default_file_explorer = true,
        })

        vim.keymap.set("n", "<Leader>-", oil.open_float, { desc = "Open parent directory" })
        vim.keymap.set("n", "<Leader>_", oil.open, { desc = "Open parent directory" })
    end,
}
