return {
    {
        "folke/lazydev.nvim",
        ft = "lua",

        ---@module "lazydev"
        ---@type lazydev.Config
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "saghen/blink.cmp",
        ft = "lua",

        ---@module "blink-cmp"
        ---@type blink.cmp.Config
        opts = {
            sources = {
                default = { "lazydev" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
        }
    }
}
