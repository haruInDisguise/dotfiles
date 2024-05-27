-- config for: https://github.com/sainnhe/gruvbox-material
return {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
        vim.opt.termguicolors = true
        vim.opt.background = 'dark'

        vim.g.gruvbox_material_diagnostic_text_highlight = true
        vim.g.gruvbox_material_diagnostic_line_highlight = true
        vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'

        vim.g.gruvbox_material_statusline_style = 'default'
        vim.g.gruvbox_material_better_performance = true

        vim.cmd 'colorscheme gruvbox-material'
    end,
}

-- return {
--     'sainnhe/everforest',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.opt.termguicolors = true
--         vim.opt.background = 'dark'
-- 
--         vim.g.everforest_enable_italics = true
--         vim.g.everforest_better_performance = true
--         vim.g.everforest_background = 'hard'
-- 
--         vim.cmd 'colorscheme everforest'
--     end,
-- }
