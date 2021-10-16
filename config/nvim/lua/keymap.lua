-- Keymaps for my Vim configuration! WOW
local global_set_keymap = vim.api.nvim_set_keymap
local mapping_options   = { silent = true, noremap = true}

vim.g.mapleader = [[ ]]

-- FANCY LEADER BINDINGS...

-- Disable search result highlightinh
global_set_keymap('n', '<Leader><esc>', '<cmd>nohlsearch<CR>', mapping_options)

-- Save file
global_set_keymap('n', '<Leader>w', '<cmd>w<CR>', mapping_options)

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
global_set_keymap('n', 'H', '0', mapping_options)
global_set_keymap('n', 'L', '$', mapping_options)
global_set_keymap('n', 'J', '}', mapping_options)
global_set_keymap('n', 'K', '{', mapping_options)

-- centering search results
global_set_keymap('n', 'n', 'nzz', mapping_options)
global_set_keymap('n', 'N', 'Nzz', mapping_options)

-- switch to last buffer and respecitve cursor position
global_set_keymap('n', '<bs>', '<c-^>`”zz', mapping_options)

-- Remove the need to press shift when using US keymap. owever,
-- this ignores your keymap and also effects, for example, the DE layout.
-- I mostly use the US Keymap, and therefore this is rather convinient.
global_set_keymap('n', ';', ':', mapping_options)

