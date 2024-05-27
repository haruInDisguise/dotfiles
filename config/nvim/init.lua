-- My Neovim configuration! Yea!

require('bootstrap')
require('utils')
require('keymap')
require('autocmds')

require('lazy').setup('plugins')

-- OPTIONS

local opt = vim.opt

-- Disable providers (see ':h provider')
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- I don't like folds..
opt.foldtext = ''
opt.foldmethod = 'manual'
opt.foldlevelstart = 99

opt.mouse = ''
opt.updatetime = 400
opt.shortmess = opt.shortmess + 'c'
opt.relativenumber = true
opt.number = true
opt.hidden = true
opt.history = 500

opt.wildmenu = true
opt.wildignore = '*/.git'

opt.laststatus = 3

-- Disable swapfiles and automatic backups
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Indentation, wrapping and scrolloff
opt.smarttab = true
opt.tabstop = 4
opt.shiftwidth = 0
opt.expandtab = true
opt.autoindent = true
opt.scrolloff = 3

opt.backspace = 'indent,start,eol'

opt.wrap = false
opt.sidescroll = 5
-- opt.listchars = 'extends:>,precedes:<'

-- Search related
opt.incsearch = true
opt.smartcase = true
opt.hlsearch = true
opt.magic = true
opt.ignorecase = true
opt.showmatch = true
opt.list = true
