---@param name string
---@param opts vim.api.keyset.highlight
local mod_hl = function(name, opts)
    local map = vim.api.nvim_get_hl( 0, {
        name = name,
    })

    if map then
        opts = vim.tbl_deep_extend("force", map, opts)
        vim.api.nvim_set_hl(0, name, opts)
    end
end

-- mod_hl("DiagnosticError", {link = "GruvboxRedSign"})
-- mod_hl("DiagnosticWarn", {link = "GruvboxYellowSign"})
