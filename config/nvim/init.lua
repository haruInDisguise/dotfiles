-- My Neovim configuration! Yea!

-- Inspiration
-- "How to Do 90% of What Plugins Do": https://www.youtube.com/watch?v=XA2WjJbmmoM
-- "The Ultimate vimrc": https://github.com/amix/vimrc

-- Resources and Tutorials
-- "Everything you need to know to configure neovim using lua": https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- "Nvim-lua-guide": https://github.com/nanotee/nvim-lua-guide

-- TODO: FIX ME PLS. Load pre_init functions and enable this config to bootstrap itself
local pre_init = require 'pre_init'

-- Load utils and several helper functions into the global scope
local utils = require 'utils'

local opt = vim.opt -- AllInOne Solution to set options

-- Load my plugins and there respective config
local plugins = require 'plugins'

-- Custom keybindings and leader mappings! yaaay
-- Leader may be set inside file 
local keymap = require 'keymap' -- {leader: [[ ]]}

-- OPTIONS

-- Experimental .7 stuff...
-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0

-- Time to wait for swap file writes
-- and 'CursorHold' events
vim.o.updatetime = 400

opt.completeopt = 'menuone,noselect'
opt.relativenumber = true
opt.number = true
opt.hidden = true
opt.history = 500
opt.so = 7

opt.wildmenu = true
opt.wildignore = '*/.git,*.o.so'

opt.laststatus = 3

-- Explicitly disable mouse support...
opt.mouse = ''

-- disable swapfiles and automatic backups
opt.swapfile = false
opt.backup = false
opt.wb = false

-- tab config, indent and scrolloff...
opt.smarttab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.scrolloff = 3

opt.backspace = 'indent,start,eol'

-- linebreak and length
opt.wrap = true
opt.lbr = true
-- opt.tw = 500

-- search related
opt.incsearch = true
opt.smartcase = true
opt.hlsearch = true
opt.magic = true
opt.ignorecase = true
opt.showmatch = true
opt.list = true

-- colorscheme
opt.termguicolors = true
opt.background = 'dark'

-- colorscheme: gruvbox-material
vim.g.gruvbox_material_diagnostic_text_highlight = true
vim.g.gruvbox_material_diagnostic_line_highlight = true
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'

vim.g.gruvbox_material_statusline_style = 'default'

vim.g.gruvbox_material_better_performance = true

vim.cmd 'colorscheme gruvbox-material'

