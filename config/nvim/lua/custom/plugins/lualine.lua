-- config for: https://github.com/hoob3rt/lualine.nvim

---@module "lazy"
---@type LazySpec
return {
    "hoob3rt/lualine.nvim",
    event = "VeryLazy",

    ---@module "lualine"
    ---@type table
    opts = {
        options = {
            theme = "gruvbox",
            icons_enabled = true,
            section_separators = "",
            component_separators = { left = "│", right = "│" },
            globalstatus = false,
        },
        sections = {
            lualine_a = { "mode", },
            lualine_b = { "branch", "diff" },
            lualine_c = { "filename" },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {},
    }
}
