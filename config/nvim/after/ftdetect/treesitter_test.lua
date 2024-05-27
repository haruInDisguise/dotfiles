-- Proper formatting for tree-sitter test files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*/test/corpus/*.txt' },
    desc = "Proper file local settings for treesitter test cases",
    callback = function(args)
        if not vim.api.nvim_buf_is_valid(args.buf) then
            return
        end

        vim.bo[args.buf].filetype = 'txt'
        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 0
    end,
})
