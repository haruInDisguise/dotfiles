-- Config for nvim-treesitter: https://github.com/nvim-treesitter/nvim-treesitter
local config = {}
local ts_config = require 'nvim-treesitter.configs'

local init = function()
    ts_config.setup {
        ensure_installed = { 
        "bash", "bibtex", "cpp", "c", "cmake", "devicetree", "dockerfile", "html", "javascript",
        "json", "latex", "lua", "python", "regex", "rust", "toml", "typescript", "vim", "yaml",
        },
        -- ensure_installed = "maintained",
        ignore_install = {""}, 
        highlight = {
            enable = true,
            disable = {""},
            -- set to true for indentation. Can be a list of languages
            additional_vim_regex_hightlighting = false,
        }
    }
end

init()

