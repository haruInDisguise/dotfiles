-- config for: https://github.com/nvim-treesitter/nvim-treesitter
local config = {}
local ts_config = require 'nvim-treesitter.configs'

local init = function()
    ts_config.setup {
        ensure_installed = {
        "bash", "fish",
        "cpp", "c", "rust", "toml",
        "devicetree", "dockerfile", "cmake",
        "html", "css", "json",
        "javascript", "typescript", "python", "lua",
        "regex", "vim", "yaml",
        "glsl",
        "latex", "bibtex",
        },
        -- ensure_installed = "maintained",
        ignore_install = {""}, 
        highlight = {
            enable = true,
            disable = {""},
            -- set to true for indentation. Can be a list of languages
            additional_vim_regex_hightlighting = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            }
        },
        ident = {
            enable = true
        }
    }
end

local load_mcfuntion_parser = function()
    local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()

    parser_config.mcfunction_lang = {
      install_info = {
        url = "https://github.com/theusaf/tree-sitter-mcfunction-lang",
        files = {"src/parser.c"},
        generate_requires_npm = true,
        requires_generate_from_grammar = false,
      },
      filetype = "mcfunction",
    }
end

init()
load_mcfuntion_parser()

