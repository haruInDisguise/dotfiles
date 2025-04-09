-- Keymaps for my vim configuration! WOW
local map_options = { noremap = true }

-- mappings for plugins are specified in there
-- respective config/<plugin>.lua file

vim.g.mapleader = [[ ]]

-- switch to prev, next buffer
vim.keymap.set('n', '<leader><leader>', '<c-^>')
vim.keymap.set('n', '<leader>d', '<cmd>bd<cr>zz')

-- yank into secondary clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>p', '"0p')

-- "de-highlight"
vim.keymap.set('n', '<c-h>', '<cmd>nohlsearch<cr>', map_options)

-- Remap escape
vim.keymap.set({ 'n', 'v', 's', 'i' }, '<C-k>', '<nop>')
vim.keymap.set({ 'n', 'v', 's', 'i' }, '<C-j>', '<esc>')

-- Save file
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', map_options)
vim.keymap.set('n', '<leader>W', '<cmd>w !sudo tee % >/dev/null<CR>', map_options)

-- center moves/jumps
-- vim.keymap.set('n', [['']], [[''zz]])
vim.keymap.set('n', 'n', 'nzz', map_options)
vim.keymap.set('n', 'N', 'Nzz', map_options)

vim.keymap.set('n', 'H', 'Hzz')
vim.keymap.set('n', 'M', 'Mzz')
vim.keymap.set('n', 'L', 'Lzz')

vim.keymap.set('n', '[[', '[[zz')
vim.keymap.set('n', ']]', ']]zz')

-- Set the context marker for large jumps
local mark_jump = function(key)
    -- FIXME: Find a way to clear v:count without
    -- relying on [[ m' ]]
    local sequence = ''
    if vim.v.count1 >= 8 then
        sequence = sequence .. [[m']] .. vim.v.count1
    end
    return sequence .. key
end
vim.keymap.set('n', 'j', function()
    return mark_jump('gj')
end, vim.tbl_extend('keep', map_options, { expr = true }));
vim.keymap.set('n', 'k', function()
    return mark_jump('gk')
end, vim.tbl_extend('keep', map_options, { expr = true }));
