-- My Neovim configuration! Yea!

-- Inspiration
-- "How to Do 90% of What Plugins Do": https://www.youtube.com/watch?v=XA2WjJbmmoM
-- "The Ultimate vimrc": https://github.com/amix/vimrc

-- Resources and Tutorials
-- "Everything you need to know to configure neovim using lua": https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- "Nvim-lua-guide": https://github.com/nanotee/nvim-lua-guide

require 'bootstrap'
require 'utils'
require 'keymap'

require 'lazy'.setup('plugins')


-- OPTIONS

-- Time to wait for swap file writes
-- and 'CursorHold' events
vim.o.updatetime = 400

local opt = vim.opt

opt.completeopt = 'menuone,noselect'
opt.relativenumber = true
opt.number = true
opt.hidden = true
opt.history = 500
opt.so = 7

opt.wildmenu = true
opt.wildignore = '*/.git,*.o.so'

opt.laststatus = 3

-- Explicitly disable mouse support
opt.mouse = ''

-- Disable swapfiles and automatic backups
opt.swapfile = false
opt.backup = false
opt.wb = false

-- Tab config, indent and scrolloff
opt.smarttab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.scrolloff = 3

opt.backspace = 'indent,start,eol'

-- Linebreak and length
opt.wrap = true
opt.lbr = true
-- opt.tw = 500

-- Search related
opt.incsearch = true
opt.smartcase = true
opt.hlsearch = true
opt.magic = true
opt.ignorecase = true
opt.showmatch = true
opt.list = true
