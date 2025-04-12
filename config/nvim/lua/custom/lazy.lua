local M = {}

M.setup = function()
    -- Plugin setup
    -- TODO: lazy.nvim provides a statusline component that indicates
    --       if there is an update for some plugin
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.uv.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end

    vim.opt.rtp:prepend(lazypath)

    ---@module "lazy"
    ---@type LazyConfig
    require("lazy").setup {
        spec = {
            { import = "custom.plugins" }
        },
        change_detection = {
            enabled = true,
            notify = false,
        },
        performance = {
            rtp = {
                disabled_plugins = {
                    "gzip",
                    "matchit",
                    "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
                }
            }
        },
        profiling = {
            loader = false,
            require = false,
        },
        ui = {
            custom_keys = {
                ["<C-i>"] = {
                    function(plugin)
                        require("lazy.core.util").notify(vim.inspect(plugin), {
                            title = "Inspect " .. plugin.name,
                            lang = "lua",
                        })
                    end,
                    desc = "Inspect Plugin",
                }
            }
        }
    }
end

return M
