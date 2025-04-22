local utils = require("custom.utils")
local function format(d)
    return string.format('%s', d.message)
end

local function suffix(d)
    return string.format(' [%s]', d.code and d.code or 'Unknown')
end

-- Setup diagnostics

-- 1. Update location list upon 'CursorHold' or 'InsertLeave'
vim.diagnostic.handlers.qflist = {
    show = function(namespace, bufnr, diagnostics, opts)
        local ns = vim.diagnostic.get_namespace(namespace)

        ns.user_data.custom_qflist_augroup = vim.api.nvim_create_augroup(
            ("custom.%s.diagnostic.qflist"):format(ns.name),
            { clear = true }
        )

        vim.api.nvim_create_autocmd({ "InsertLeave", "CursorHold" }, {
            group = ns.user_data.custom_qflist_augroup,
            callback = function()
                local winid = vim.api.nvim_get_current_win()
                vim.diagnostic.setqflist({
                    open = true,
                })
                vim.api.nvim_set_current_win(winid)
            end,
        })
    end,
    hide = function(ns_id)
        local ns = vim.diagnostic.get_namespace(ns_id)
        if ns.user_data and ns.user_data.custom_qflist_augroup then
            vim.api.nvim_del_augroup_by_id(ns.user_data.custom_qflist_augroup)
        end
    end,
}

---@type vim.diagnostic.Opts.VirtualText
local virtual_text_opts = {
    hl_mode = "combine",
    source = false,
    prefix = '●',
    spacing = 4,
    format = format,
    suffix = suffix,
}

local float_opts = {
    source = false,
    border = vim.g.border_style,
    severity_sort = true,
    format = format,
    suffix = suffix,
}

vim.diagnostic.config({
    qflist = false,
    jump = {
        warp = true,
    },
    float = float_opts,
    virtual_text = virtual_text_opts,
    virtual_lines = false,
    signs = false,
    severity_sort = true,
})

local M = {}

M.toggle_qflist = function()
end

return M
