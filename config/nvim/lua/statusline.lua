local M = {}

local default_hi = function(name, style)
    opts = {
        name = '',
    }
    local ok, hl = pcall(vim.api.nvim_get_hl(name, style, opts)
end

M.setup = function()
    default_hi()
end
