-- I'm using 'packer.nvim' as my plugin manager: https://github.com/wbthomason/packer.nvim
local packer = require 'packer'
local packer_config = {}

local init = function(options)
    local use = packer.use

    packer.init(packer_config)
    packer.reset()

    -- Make packer responsible for updating itself
    use { 'wbthomason/packer.nvim' }

    -- Colorschemes, Show Color Codes and Statusline
    use 'sainnhe/gruvbox-material'

    use {
        'hoob3rt/lualine.nvim',
        config = [[ require 'config.lualine' ]],
    }
    use {
        'norcalli/nvim-colorizer.lua',
        config = [[ require 'config.colorizer' ]]
    }

    -- LSP, Completion, Troubleshooting and Treesitter
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
        }
    }

    use {
        'sirver/UltiSnips',
        config = [[ require 'config.ultisnips' ]],
        requires = {
            'honza/vim-snippets'
        }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        config = [[ require 'config.treesitter' ]],
        run = ':TSUpdate' 
    }
    use {
        'lervag/vimtex',
        config = [[ require 'config.vimtex' ]]
    }

    -- Telescope! Yay
    use {
        'nvim-telescope/telescope.nvim',
        config = [[ require 'config.telescope' ]],
        requires = 'nvim-lua/plenary.nvim',
    }

    use {
        'simrat39/rust-tools.nvim',
        config = [[ require 'config.rust-tools' ]],
        requires = 'nvim-telescope/telescope-ui-select.nvim',
    }
end

init()
