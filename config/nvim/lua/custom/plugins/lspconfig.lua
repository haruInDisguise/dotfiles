-- config for:
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/neovim/nvim-lspconfig

---@module "lazy"
---@type LazySpec
return {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    enabled = false,

    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },

    opts = function()
        local lsp = require('lspconfig')

        return {
            ---@module "lspconfig.configs"
            ---@type lspconfig.Config
            default_config = {
                document_highlight = {
                    enabled = true,
                },
                flags = {
                    debounce_text_changes = 150,
                },
            },
            server_list = {
                ["ts_ls"] = {
                    auto_install = true,
                    config = {
                        root_dir = lsp.util.root_pattern("package.json"),
                        single_file_support = false
                    }
                },
                ["csharp_ls"] = {
                    auto_install = true,
                    config = {},
                },
                ["pylsp"] = {
                    auto_install = true,
                    config = {
                        settings = {
                            pylsp = {
                                plugins = {
                                    pycodestyle = { enabled = false }
                                }
                            }
                        }
                    }
                },
                ["texlab"] = {
                    auto_install = true,
                    config = {},
                },
                ["lua_ls"] = {
                    auto_install = true,
                    config = {},
                },
                ["zls"] = {
                    auto_install = true,
                    config = {},
                },
                ["clangd"] = {
                    auto_install = false,
                    config = {
                        cmd = {
                            "clangd",
                            "--background-index",
                            "--background-index-priority=normal",
                            "--clang-tidy",
                            "--completion-style=detailed",
                            "--function-arg-placeholders",
                            "--header-insertion=never",
                        },
                        root_markers = { 'compile_commands.json', 'build/compile_commands.json' }
                    },
                },
                ["denols"] = {
                    auto_install = false,
                    config = {
                        root_dir = lsp.util.root_pattern("deno.json", "deno.jsonc")
                    }
                },
            }
        }
    end,
    config = function(_, opts)
        local default_config = opts.default_config
        local server_list = opts.server_list

        ---@module "mason"
        ---@type MasonSettings
        require("mason").setup {
            PATH = "prepend",
        }

        local mason_server_list = vim.tbl_filter(function(item)
            return server_list[item].auto_install
        end, vim.tbl_keys(server_list))

        ---@module "mason-lspconfig"
        ---@type MasonLspconfigSettings
        require("mason-lspconfig").setup {
            ensure_installed = mason_server_list,
            automatic_installation = false,
            handlers = nil
        }

        -- Disable snippet support by default
        -- see: https://github.com/hrsh7th/nvim-cmp/issues/1129#issuecomment-1837594834
        -- default_config.capabilities = require("blink.cmp.sources.lib").get_lsp_capabilities()
        -- default_config.capabilities.textDocument.completion.completionItem.snippetSupport = false

        for item, k in pairs(server_list) do
            local c = vim.tbl_extend("force", default_config, k.config)
            vim.lsp.config(item, c)
            vim.lsp.enable(item)
        end

        -- Setup config
        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "'on_attach' hook for LSP clients",
            callback = function(args)
                local leader = [[,]]
                local map_config = { noremap = true, buffer = args.buf }

                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    vim.keymap.set("n", "<leader>uh", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
                    end, { desc = "Toggle inlay hints" })
                end

                local set_key = function(mode, lhs, rhs, config)
                    vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend('keep', config, map_config))
                end

                set_key("n", "gK", function()
                    local old_opts = vim.diagnostic.config()

                    if not old_opts then
                        return
                    end

                    vim.diagnostic.config({
                        virtual_text = not old_opts.virtual_text or false,
                        virtual_lines = not old_opts.virtual_lines or false,
                    })
                end, {})

                vim.keymap.set("n", "<leader>h", vim.lsp.buf.type_definition, map_config)

                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, map_config)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, map_config)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, map_config)

                vim.keymap.set("n", leader .. "e", vim.diagnostic.open_float, map_config)
                vim.keymap.set("n", leader .. "q", vim.diagnostic.setqflist, map_config)

                vim.keymap.set("n", leader .. "wa", vim.lsp.buf.add_workspace_folder, map_config)
                vim.keymap.set("n", leader .. "wr", vim.lsp.buf.remove_workspace_folder, map_config)
                vim.keymap.set("n", leader .. "wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, map_config)

                vim.keymap.set("n", leader .. "r", vim.lsp.buf.rename, map_config)
                vim.keymap.set("n", leader .. "f", function()
                    vim.lsp.buf.format { async = false };
                end, map_config)
            end,
        })
    end,
}
