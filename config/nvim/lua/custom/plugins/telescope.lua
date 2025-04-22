-- config for: https://github.com/nvim-telescope/telescope.nvim

return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    ---@module "telescope"
    opts = {
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = function()
                        vim.cmd [[stopinsert]]
                    end,
                },
                n = {
                    ["<C-j>"] = "close"
                },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                overwrite_generic_sorter = true,
                overwrite_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    },
    config = function(_, opts)
        local utils = require("custom.utils")
        local builtin = require("telescope.builtin")
        local tscope = require("telescope")
        local themes = require("telescope.themes")
        opts.defaults = themes.get_ivy(opts.defaults)

        tscope.setup(opts)
        tscope.load_extension("fzf")
        tscope.load_extension("ui-select")

        local set_keymap = utils.keymap.get_func_with_config({
            silent = true,
            noremap = true,
        })

        set_keymap("n", "<leader>f", function()
            builtin.find_files({
                previewer = false,
            })
        end, {desc = "Open telescope find_files"})
        set_keymap("n", "<leader>/", function()
            builtin.live_grep({
                previewer = true,
            })
        end, {desc = "Open telescope live_grep"})
        set_keymap("n", "<leader>r", builtin.registers, {desc = "Open telescope registers"})
        set_keymap("n", "<leader>b", builtin.buffers, {desc = "Open telescope buffers"})
    end,
}
