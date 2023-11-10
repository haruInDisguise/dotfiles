-- config for: https://github.com/nvim-treesitter/nvim-treesitter
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'VeryLazy',
    config = function(plug, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
    opts = {
        ensure_installed = {
            "bash", "fish",
            "cpp", "c", "rust", "toml",
            "dockerfile", "cmake",
            "html", "css", "json",
            "javascript", "typescript", "python", "lua",
            "regex", "vim", "yaml",
            "glsl",
            "latex", "bibtex",
            "vimdoc",
        },
        ignore_install = {""}, 
        highlight = { enable = true },
        ident = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            }
        },
    }
}
