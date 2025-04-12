-- config for: https://github.com/stevearc/oil.nvim

---@module "lazy"
---@type LazySpec
return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,

    -- "VeryLazy" prevents oil from replacing netrw. In general, lazy loading is discouraged
    ---@module "lazy"
    ---@type LazyKeysSpec[]
    keys = {
        {
            "<leader>-",
            function()
                require("oil").open()
            end,
            mode = "n",
        }
    },

    ---@module "oil"
    ---@type oil.Config
    opts = {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, _)
                local ignore = { ".git", }
                return ignore[name] ~= nil
            end
        },
    },

}
