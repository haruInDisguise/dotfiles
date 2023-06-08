-- I'm using 'packer.nvim' as my plugin manager: https://github.com/wbthomason/packer.nvim
local packer = require 'packer'

local init = function(options)
    local use = packer.use

    packer.init(packer_config)
    packer.reset()

    -- Make packer responsible for updating itself
    use { 'wbthomason/packer.nvim' }

    -- Colorscheme
    use { 'sainnhe/gruvbox-material' }

    use {
        'hoob3rt/lualine.nvim',
        config = [[ require 'config.lualine' ]],
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = [[ require 'config.colorizer' ]]
    }

    -- LSP, Completion, Snippets, Troubleshooting and Treesitter
    use {
        'neovim/nvim-lspconfig',
        config = [[ require 'config.lsp' ]],
    }

    use {
        'hrsh7th/nvim-cmp',
        config = [[ require 'config.cmp' ]],
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'onsails/lspkind.nvim',
        }
    }

    use {
        'L3MON4D3/LuaSnip',
        tag = 'v<CurrentMajor>.*',
        config = [[ require 'config.luasnip' ]],
        requires = {
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
        }
    }

    -- Treesitter for fancy syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        config = [[ require 'config.treesitter' ]],
        run = ':TSUpdate' 
    }

    -- Latex for writing
    use {
        'lervag/vimtex',
        config = [[ require 'config.vimtex' ]]
    }

    -- Arduino plugin for embeded programming
    -- TODO

    -- Telescope! Yay
    use {
        'nvim-telescope/telescope.nvim',
        config = [[ require 'config.telescope' ]],
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'nvim-telescope/telescope-ui-select.nvim',

            'nvim-telescope/telescope-file-browser.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },

            'nvim-telescope/telescope-project.nvim',
            'sudormrfbin/cheatsheet.nvim',
        }
    }

    -- LSP CONFIG

    -- rust
    use {
        'simrat39/rust-tools.nvim',
        config = [[ require 'config.rust-tools' ]],
        requires = 'nvim-telescope/telescope-ui-select.nvim',
    }
end

init()
