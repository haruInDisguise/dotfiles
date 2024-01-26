-- config for: https://github.com/nvim-neorg/neorg
return {
    'nvim-neorg/neorg',

    dependencies = { "nvim-lua/plenary.nvim" },
    ft = 'norg',
    cmd = 'Neorg',
    build = ":Neorg sync-parsers",
    config = function()
        local neorg = require('neorg')

        neorg.setup {
            load = {
                ["core.defaults"] = {},
                ["core.journal"] = {
                    config = {
                        journal_folder = "journal",
                        strategy = "flat",
                        template_name = "template.norg",
                        use_template = true,
                        workspace = "general",
                    },
                },
                ["core.concealer"] = {},
                ["core.dirman"] = {
                    config = {
                        default_workspace = "general",
                        use_popup = true,
                        workspaces = {
                            general = "~/notes/general",
                        },
                    },
                },
            },
        }
    end,
}
