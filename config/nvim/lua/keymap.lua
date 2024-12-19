-- Keymaps for my vim configuration! WOW
local set_keymap = vim.keymap.set
local delete_keymap = vim.keymap.del
local map_options   = { noremap = true }
local map_silent = vim.tbl_extend('keep', map_options, { silent = true })

-- mappings for plugins are specified in there
-- respective config/<plugin>.lua file

vim.g.mapleader = [[ ]]
set_keymap('n', '<Space>', '<Nop>', {})

-- switch to prev, next buffer
set_keymap('n', '<leader><leader>', '<c-^>')
set_keymap('n', '<leader>n', '<cmd>bn<cr>zz')
set_keymap('n', '<leader>p', '<cmd>bp<cr>zz')
set_keymap('n', '<leader>d', '<cmd>bd<cr>zz')

-- yank into secondary clipboard
set_keymap('n', '<leader>y', '"+y')
set_keymap('n', '<leader>p', '"0p')

-- "de-highlight"
set_keymap('n', '<c-h>', '<cmd>nohlsearch<cr>', map_options)

-- Remap escape
set_keymap({'n', 'v', 's', 'i'}, '<C-k>', '<nop>')
set_keymap({'n', 'v', 's', 'i'}, '<C-j>', '<esc>')
set_keymap({'n', 'v', 's', 'i'}, '<C-[>', '<nop>')

-- Save file
set_keymap('n', '<leader>w', '<cmd>w<CR>', map_options)
set_keymap('n', '<leader>W', '<cmd>w !sudo tee % >/dev/null<CR>', map_options)

-- center moves/jumps
set_keymap('n', [['']], [[''zz]])
set_keymap('n', 'n', 'nzz', map_options)
set_keymap('n', 'N', 'Nzz', map_options)

set_keymap('n', 'H', 'Hzz')
set_keymap('n', 'M', 'Mzz')
set_keymap('n', 'L', 'Lzz')

set_keymap('n', '[[', '[[zz')
set_keymap('n', ']]', ']]zz')

-- always just move one "visual line" up or down
set_keymap('n', 'j', 'gj', map_options)
set_keymap('n', 'k', 'gk', map_options)
