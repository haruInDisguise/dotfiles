-- My Neovim config! Yay!

vim.loader.enable(true)

require('utils')
require('keymap')
require('autocmds')

-- Plugin setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
require('lazy').setup {
    spec = {
        { import = 'plugins' }
    },
    change_detection = {
        notify = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "matchit",
                "netrwPlugin",
                "zipPlugin",

                "gzip",
                "tarPlugin",
                "tutor",
                "tohtml",
            }
        }
    }
}

-- LSP Debugging
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

-- Options
vim.g.clipboard = 'osc52'

-- Disable providers I don't need (see ':h provider')
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- I don't like folds..
vim.opt.foldtext = ''
vim.opt.foldmethod = 'manual'
vim.opt.foldlevelstart = 99

vim.opt.mouse = ''
vim.opt.updatetime = 400
vim.opt.shortmess = vim.opt.shortmess + 'c'
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.hidden = true
vim.opt.history = 500

vim.opt.wildmenu = true
vim.opt.wildignore = '*/.git'

vim.opt.laststatus = 3

-- Disable swapfiles and automatic backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Indentation, wrapping and scrolloff
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.scrolloff = 3

vim.opt.backspace = 'indent,start,eol'

vim.opt.wrap = false
vim.opt.sidescroll = 5
-- opt.listchars = 'extends:>,precedes:<'

vim.opt.inccommand = 'split'

-- Search related
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.magic = true
vim.opt.ignorecase = true
vim.opt.showmatch = true
vim.opt.list = true
