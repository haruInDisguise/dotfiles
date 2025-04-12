-- config for: https://github.com/nvim-telescope/telescope.nvim

return {
    "nvim-telescope/telescope.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
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
                        -- FIXME: Find a pure lua solution...
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
        local builtin = require("telescope.builtin")
        local tscope = require("telescope")
        local themes = require("telescope.themes")

        opts.defaults = themes.get_ivy(opts.defaults)
        tscope.setup(opts)
        tscope.load_extension("fzf")
        tscope.load_extension("ui-select")

        local keymap_options = {
            silent = true,
            noremap = true,
        }

        vim.keymap.set("n", "<leader>f", function()
            builtin.find_files({
                previewer = false,
            })
        end, keymap_options)
        vim.keymap.set("n", "<leader>/", function()
            builtin.live_grep({
                previewer = true,
            })
        end, keymap_options)
        vim.keymap.set("n", "<leader>r", builtin.registers, keymap_options)
        vim.keymap.set("n", "<leader>b", builtin.buffers, keymap_options)
    end,
}
