-- I'm using 'lazy.nvim' as my plugin manager: https://github.com/folke/lazy.nvim
-- Most Plugins have there own config in: lua/plugins/<plugin>.lua

return {
    -- Colorscheme
    {
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
    },

    { 'hoob3rt/lualine.nvim' },
    { 'norcalli/nvim-colorizer.lua' },

    -- LSP, Completion, Snippets etc.
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    { 'nvim-treesitter/nvim-treesitter' },

    -- Latex
    { 'lervag/vimtex' },
    -- Telescope! Yay
    { 'nvim-telescope/telescope.nvim' },
    -- rust
    { 'simrat39/rust-tools.nvim'},
}
