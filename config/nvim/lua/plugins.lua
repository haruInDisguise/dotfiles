-- Loading my plugins and their respective configuration
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
    'hrsh7th/nvim-compe',
    config = [[ require 'config.compe' ]],
  }

  use { 
    'nvim-treesitter/nvim-treesitter', 
    config = [[ require 'config.treesitter' ]],
    run = ':TSUpdate' 
  }
  use { 
    'folke/trouble.nvim',
    config = [[ require 'config.trouble' ]],
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Plugins by @tpope
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'

  -- Telescope! Yay
  use {
    'nvim-telescope/telescope.nvim',
    config = [[ require 'config.telescope' ]],
    requires = 'nvim-lua/plenary.nvim',
  }
end

init()
