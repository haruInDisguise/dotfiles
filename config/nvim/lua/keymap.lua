-- Keymaps for my vim configuration! WOW
local set_keymap = vim.keymap.set
local mapping_options   = { silent = true }

vim.g.mapleader = [[ ]]
-- FANCY LEADER BINDINGS...

-- switch to prev, next buffer
set_keymap('n', '<Tab>', '<cmd>bn<cr>zz')
set_keymap('n', '<bs>', '<cmd>bp<cr>zz')

-- "de-highlight"
set_keymap('n', '<Leader><esc>', '<cmd>nohlsearch<cr>', mapping_options)

-- Save file
set_keymap('n', '<Leader>w', '<cmd>w<CR>', mapping_options)
set_keymap('n', '<Leader>W', '<cmd>w !sudo tee % >/dev/null<CR>', mapping_options)

-- Quit buffer or exit
set_keymap('n', '<Leader>q', '<cmd>bd<CR>', mapping_options)

-- Remapping some default bindings and overall quality of life stuff...
set_keymap('n', '<Space>', '<Nop>', {})

set_keymap('n', 'j', '<Nop>', {})
set_keymap('n', 'k', '<Nop>', {})
set_keymap('n', 'j', 'gj', mapping_options)
set_keymap('n', 'k', 'gk', mapping_options)

-- centering search results
set_keymap('n', 'n', 'nzz', mapping_options)
set_keymap('n', 'N', 'Nzz', mapping_options)

-- is this a good idea?
set_keymap('n', ';', ':', mapping_options)
