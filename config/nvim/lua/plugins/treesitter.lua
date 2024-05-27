-- config for: https://github.com/nvim-treesitter/nvim-treesitter
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'VeryLazy',
    dependencies = {
        { "nushell/tree-sitter-nu" },
    },
    config = function(plug, opts)
        require('nvim-treesitter.configs').setup(opts)

        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        parser_config.mcfunction = {
            install_info = {
                url = '~/projects/coding/minecraft/tree-sitter-mcfunction',
                files = {'src/parser.c'}, -- TODO: Add scanner.c
                branch = 'main',
                generate_requires_npm = false,
                requires_generate_from_grammar = false,
            },
            filetype = 'mcfunction',
        }
        vim.treesitter.language.register('mcfunction', 'mcfunction')
    end,
    opts = {
        ensure_installed = {
            'bash', 'fish',
            'cpp', 'c', 'rust', 'toml',
            'dockerfile', 'dot', 'cmake',
            'html', 'css', 'json',
            'javascript', 'typescript', 'python', 'lua',
            'regex', 'vim', 'yaml',
            'query',
            'latex', 'bibtex',
            'vimdoc',
        },
        highlight = { enable = true },
        ident = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = 'gnn',
                node_incremental = 'grn',
                scope_incremental = 'grc',
                node_decremental = 'grm',
            }
        },
    }
}
