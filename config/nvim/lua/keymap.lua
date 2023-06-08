-- Keymaps for my vim configuration! WOW
local set_keymap = vim.keymap.set
local mapping_options   = { silent = true }

-- mappings for plugins are specified in there
-- respective config/<plugin>.lua file

vim.g.mapleader = [[ ]]
-- FANCY LEADER BINDINGS...
-- nvim > 0.7's vim.keymap.set includes noremap by default (see: :h lua-keymap)

-- switch to prev, next buffer
set_keymap('n', '<Tab>', '<cmd>bn<cr>zz')
set_keymap('n', '<bs>', '<cmd>bp<cr>zz')

set_keymap('n', '<Leader><bs>', '<cmd>bd<cr>zz')

-- "de-highlight"
set_keymap('n', '<Leader><esc>', '<cmd>nohlsearch<cr>', mapping_options)

-- Save file
set_keymap('n', '<Leader>w', '<cmd>w<CR>', mapping_options)
set_keymap('n', '<Leader>W', '<cmd>w !sudo tee % >/dev/null<CR>', mapping_options)

-- Quit buffer or exit
set_keymap('n', '<Leader>q', '<cmd>bd<CR>', mapping_options)

set_keymap('n', 'H', 'Hzz')
set_keymap('n', 'M', 'Mzz')
set_keymap('n', 'L', 'Lzz')

-- Remapping some default bindings and overall quality of life stuff...
set_keymap('n', '<Space>', '<Nop>', {})

set_keymap('n', 'j', '<Nop>', {})
set_keymap('n', 'k', '<Nop>', {})
set_keymap('n', 'j', 'gj', mapping_options)
set_keymap('n', 'k', 'gk', mapping_options)

-- centering search results
set_keymap('n', 'n', 'nzz', mapping_options)
set_keymap('n', 'N', 'Nzz', mapping_options)

set_keymap('n', [['']], [[''zz]])
