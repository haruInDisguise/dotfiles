-- config for: https://github.com/simrat39/rust-tools.nvim
return {
    {
        'simrat39/rust-tools.nvim',
        dependencies = 'nvim-telescope/telescope-ui-select.nvim',
        ft = 'rust',
        opts = {
            tools = {},
            server = {
                on_attach = function(client, bufnr)
                    lsp_setup_server_on_attach(client, bufnr)
                end
            },
        }
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                runBuildScripts = true,
                            },
                            -- Add clippy lints for Rust.
                            checkOnSave = {
                                allFeatures = true,
                                command = "clippy",
                                extraArgs = { "--no-deps" },
                            },
                            procMacro = {
                                enable = true,
                                ignored = {
                                    ["async-trait"] = { "async_trait" },
                                    ["napi-derive"] = { "napi" },
                                    ["async-recursion"] = { "async_recursion" },
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

