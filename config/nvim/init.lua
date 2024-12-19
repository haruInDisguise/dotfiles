-- My Neovim config! Yay!

require('utils')
require('keymap')
require('autocmds')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
    spec = {
        { import = 'plugins' }
    },
    change_detection = {
        notify = false,
    }
})

vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local lvl = ({ 'ERROR', 'WARN', 'INFO', 'DEBUG' })[result.type]
  print(result.message, lvl, {
    title = 'LSP | ' .. client.name,
    timeout = 10000,
    keep = function()
      return lvl == 'ERROR' or lvl == 'WARN'
    end,
  })
end

-- OPTIONS
local opt = vim.opt

-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--   },
--   paste = {
--     ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--   },
-- }


-- Disable providers I don't need (see ':h provider')
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

opt.inccommand = 'split'

-- Search related
opt.incsearch = true
opt.smartcase = true
opt.hlsearch = true
opt.magic = true
opt.ignorecase = true
opt.showmatch = true
opt.list = true
