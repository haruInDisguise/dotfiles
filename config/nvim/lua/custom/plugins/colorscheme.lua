-- config for: https://github.com/ellisonleao/gruvbox.nvim

---@module "lazy"
---@type LazySpec
return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,

        ---@module "gruvbox"
        ---@type GruvboxConfig
        opts = {
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
            inverse = true,
            contrast = "hard",
            palette_overrides = {},
            overrides =
            {
                -- LspReferenceTarget = { standout = true },
            },
            dim_inactive = false,
            transparent_mode = false,
        },

        init = function()
            vim.cmd([[ colorscheme gruvbox ]])
        end,
    }
}
