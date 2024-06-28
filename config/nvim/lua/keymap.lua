-- Keymaps for my vim configuration! WOW
local set_keymap = vim.keymap.set
local delete_keymap = vim.keymap.del
local mapping_options   = { silent = true }

-- mappings for plugins are specified in there
-- respective config/<plugin>.lua file

vim.g.mapleader = [[ ]]
set_keymap('n', '<Space>', '<Nop>', {})

-- switch to prev, next buffer
set_keymap('n', '<Tab>', '<cmd>bn<cr>zz')
set_keymap('n', '<bs>', '<cmd>bp<cr>zz')

-- yank into secondary clipboard
set_keymap('n', '<Leader>y', '"+y')

-- "de-highlight"
set_keymap('n', '<Leader><esc>', '<cmd>nohlsearch<cr>', mapping_options)

-- Save file
set_keymap('n', '<Leader>w', '<cmd>w<CR>', mapping_options)
set_keymap('n', '<Leader>W', '<cmd>w !sudo tee % >/dev/null<CR>', mapping_options)

-- center moves/jumps
set_keymap('n', [['']], [[''zz]])
set_keymap('n', 'n', 'nzz', mapping_options)
set_keymap('n', 'N', 'Nzz', mapping_options)

set_keymap('n', 'H', 'Hzz')
set_keymap('n', 'M', 'Mzz')
set_keymap('n', 'L', 'Lzz')

-- always just move one "visual line" up or down
set_keymap('n', 'j', 'gj', mapping_options)
set_keymap('n', 'k', 'gk', mapping_options)
