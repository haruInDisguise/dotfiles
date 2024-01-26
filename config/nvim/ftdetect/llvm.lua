vim.g.filetype_ll = 'llvm'
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*.ll' },
    callback = function(args)
        if not vim.api.nvim_buf_is_valid(args.buf) then
            return
        end

        vim.api.nvim_buf_call(args.buf,
            function()
                vim.api.nvim_cmd({ cmd = 'set', args = { 'ft=llvm' }}, {})
            end
        )
    end,
})
