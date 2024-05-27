vim.g.filetype_ll = 'llvm'
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*.ll' },
    desc = "Overwrite filetype for '*.ll' files to match 'llvm'",
    callback = function(args)
        if not vim.api.nvim_buf_is_valid(args.buf) then
            return
        end

        vim.bo[args.buf].filetype = 'llvm'
    end,
})
