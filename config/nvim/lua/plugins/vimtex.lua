-- config for: https://github.com/lervag/vimtex
return {
    'lervag/vimtex',
    ft = 'tex',
    config = function()
        vim.g.vimtex_view_method = 'zathura'
        -- vim.g.tex_flavour = 'latex'

        vim.g.vimtex_compiler_method = 'latexmk'
        vim.g.vimtex_compiler_latexmk = { build_dir = 'build' }

        vim.g.vimtex_complete_bib = { simple = true }
    end,
}
