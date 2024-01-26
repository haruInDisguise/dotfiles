-- config for: https://github.com/stevearc/oil.nvim
return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- 'VeryLazy' prevents oil from replacing netrw
    event = 'VimEnter',
    opt = {
        default_file_explorer = true,
    },
    config = function(_, opt)
        local oil = require('oil')
        oil.setup(opt)

        vim.keymap.set("n", "-", oil.open_float, { desc = "Open parent directory" })
    end,
}
