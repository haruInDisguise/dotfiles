-- config for: https://github.com/Saghen/blink.cmp

---@module "lazy"
---@type LazySpec
return {
    "saghen/blink.cmp",
    build = "cargo build --release",

    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
        completion = {
            menu = {
                draw = {
                    treesitter = { "lsp" }
                },
            },
            list = {
                selection = {
                    preselect = true, auto_insert = false
                },
            },
        },

        cmdline = {
            keymap = {
                preset = "default",
                   ['<C-space>'] = { 'show_and_insert', 'show_documentation', 'hide_documentation' },
                --    ['<C-e>'] = { 'cancel', 'fallback' },
                --    ['<C-y>'] = { 'select_and_accept' },
                --    ['<Up>'] = { 'select_prev', 'fallback' },
                --    ['<Down>'] = { 'select_next', 'fallback' },
                --    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
                --    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
                --    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                --    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
                --    ['<Tab>'] = { 'snippet_forward', 'fallback' },

            }
        },

        keymap = {
            preset = "default",
            ['<C-space>'] = { 'show_and_insert', 'show_documentation', 'hide_documentation' },
        },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp"s highlight groups
            -- Useful for when your theme doesn"t support blink.cmp
            -- will be removed in a future release
            use_nvim_cmp_as_default = false,
            -- Set to "mono" for "Nerd Font Mono" or "normal" for "Nerd Font"
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono"
        },

        -- default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, via `opts_extend`
        sources = {
            default = { "lsp", "path", "buffer" },
        },

        -- experimental signature help support
        signature = {
            enabled = true,
            window = {
                winhighlight = "NormalFloat:Normal",
            },
        }
    },

    config = function(_, opts)
        vim.api.nvim_create_autocmd("InsertEnter", {
            callback = function(_)
                require('blink-cmp').setup(opts)
            end,
            once = true,
            desc = "Register blink-cmp upon entering insert mode",
        })
    end,

    opts_extend = {
        "sources.default",
        "sources.providers",
    },
}
