local opts = {
    buffer = vim.api.nvim_get_current_buf(),
    noremap = true,
    silent = true,
}

-- vim.keymap.del('n', 'J', { buffer = vim.api.nvim_get_current_buf() })
vim.keymap.set('n', 'J', function()
    vim.cmd.RustLsp('joinLines')
end, opts)
