-- Keymaps for my Vim configuration! WOW
local global_set_keymap = vim.api.nvim_set_keymap
local mapping_options   = { silent = true, noremap = true}

vim.g.mapleader = [[ ]]

-- FANCY LEADER BINDINGS...

-- Disable search result highlightinh
global_set_keymap('n', '<Leader><esc>', '<cmd>nohlsearch<CR>', mapping_options)

-- Save file
global_set_keymap('n', '<Leader>w', '<cmd>w<CR>', mapping_options)
global_set_keymap('n', '<Leader>W', '<cmd>w !sudo tee % >/dev/null<CR>', mapping_options)

-- Quit buffer or exit
global_set_keymap('n', '<Leader>q', '<cmd>bd<CR>', mapping_options)

-- REMAPPING SOME DEFAULT BINDINGS AND OVERALL QUALITY OF LIFE STUFF...

-- Explicitly unmap some default bindings.
global_set_keymap('n', '<Space>', '<Nop>', {})
global_set_keymap('n', 'J', '<Nop>', {})
global_set_keymap('n', 'K', '<Nop>', {})
global_set_keymap('n', 'H', '<Nop>', {})
global_set_keymap('n', 'L', '<Nop>', {})

-- more "powerful" version of hjkl or something
global_set_keymap('n', 'H', '^', mapping_options)
global_set_keymap('n', 'L', '$', mapping_options)
global_set_keymap('n', 'J', '}', mapping_options)
global_set_keymap('n', 'K', '{', mapping_options)

global_set_keymap('n', 'j', 'gj', mapping_options)
global_set_keymap('n', 'k', 'gk', mapping_options)

-- centering search results
global_set_keymap('n', 'n', 'nzz', mapping_options)
global_set_keymap('n', 'N', 'Nzz', mapping_options)

-- switch to previous buffer
global_set_keymap('n', '<bs>', '<cmd>bp<CR>zz', mapping_options)

-- is this a good idea?
global_set_keymap('n', ';', ':', mapping_options)

