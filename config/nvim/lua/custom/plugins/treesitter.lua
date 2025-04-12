-- config for: https://github.com/nvim-treesitter/nvim-treesitter

---@module "lazy"
---@type LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = "VeryLazy",

    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },

    ---@type TSConfig
    mpts = {
        ensure_installed = {
            "bash",
            "bibtex",
            "c",
            "cmake",
            "cpp",
            "css",
            "dockerfile",
            "dot",
            "fish",
            "html",
            "javascript",
            "json",
            "latex",
            "lua",
            "python",
            "query",
            "regex",
            "rust",
            "toml",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",

        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = "grc",
                node_decremental = "grm",
            }
        },
        ident = { enable = true },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
            },
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
