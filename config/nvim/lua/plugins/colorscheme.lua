-- config for: https://github.com/sainnhe/gruvbox-material
return {
    {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require("gruvbox").setup({
            terminal_colors = true,
            undercurl = true,
            underline = true,
            bold = false,
            italic = {
                strings = true,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "hard", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides =
            {
                SignColumn = { bg = '#323232' }
            },
            dim_inactive = false,
            transparent_mode = false,
        })
        vim.cmd([[ colorscheme gruvbox ]])
    end,
    },
    -- {
    --     "wincent/base16-nvim",
    --     lazy = false, -- load at start
    --     priority = 1000, -- load first
    --     config = function()
    --         vim.o.background = 'dark'
    --         -- Make comments more prominent -- they are important.
    --         local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
    --         vim.api.nvim_set_hl(0, 'Comment', bools)
    --         -- Make it clearly visible which argument we're at.
    --         local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
    --         vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
    --
    --         -- vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
    --     end
    -- },
}

