-- My Neovim config! Yay!

-- TODO:
-- 1. Configurations can be specified in "lsp/<name>.lua"
--      - Use this feature. I've been wanting to split my lsp configs anyway,
--        and now this task became trivial... nice
--      - COMPLETELY REMOVE lspconfig. It is now a data-only repository that provides sane default
--        configurations. Its programatic api (ie. LspRestart etc.) is deprecatef
-- 2. 'commentstring' now supports TS queries
--      - I could potentially override the default keybind to add support
--        for multi line comments + ignore empty lines
-- 3. Figure out how 'vim.ui.open()' parses paths/URIs
-- 4. Make use of 'vim.diagnostic.setqflist()'
-- 5. Look into how ':h: is actually implemented
--      - Can I open multiple help buffers in the same tab?
--          -> No(?). ":tab help" can be used to create a seperate tab
--      - How do doc-links work (ie. 'K' binding)?
--      - Find a way to move back the the previous doc-link
-- 6. Implement my own 'statusline' and remove dependece on 'lualine.nvim'
--      - Look into 'titlestring', 'statuscolumn', 'rulerformat'
-- 7. Pass the (highlighted) word under the cursor (use 'semantic token'?) as
--    an argument to Treesitters livegrep picker
--      - '"/' register holds the last search pattern
-- 8. Don't close a split window when deleting its buffer
--      - '#' is the alternate filename (filename of the previous active buffer)

vim.loader.enable(true)
vim.g.mapleader = [[ ]]
require("custom.utils")

require("custom.lazy").setup()
require("custom.autocmds")
require("custom.keymap")

-- Options
vim.g.clipboard = "osc52"

-- Disable providers I don"t need (see ":h provider")
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- I don"t like folds..
vim.opt.foldtext = ""
vim.opt.foldmethod = "manual"
vim.opt.foldlevelstart = 99

vim.opt.mouse = ""
vim.opt.updatetime = 400
vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.hidden = true
vim.opt.history = 500

vim.opt.wildmenu = true
vim.opt.wildignore = "*/.git"

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

vim.opt.backspace = "indent,start,eol"

vim.opt.wrap = false
vim.opt.sidescroll = 5
-- opt.listchars = "extends:>,precedes:<"

vim.opt.inccommand = "split"

-- Search related
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.magic = true
vim.opt.ignorecase = true
vim.opt.showmatch = true
vim.opt.list = true
