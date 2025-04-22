-- config for: https://github.com/folke/lazy.nvim

-- TODO: lazy.nvim provides a statusline component that indicates
--       if there is an update for some plugin
local utils = require('custom.utils')
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",     -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

---@module "lazy"
---@type LazyConfig
require("lazy").setup {
    defaults = {
        lazy = true,
    },
    spec = {
        { import = "custom.plugins" }
    },
    rocks = {
        enabled = false,
    },
    change_detection = {
        enabled = false,
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
        -- loader = false,
        require = false,
    },
    ui = {
        custom_keys = {
            ["<C-i>"] = {
                function(plugin)
                    utils.debug.dump(plugin)
                end,
                desc = "Inspect Plugin",
            }
        }
    }
}
