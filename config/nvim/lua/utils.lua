function _G.debug_dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
    return ...
end

function _G.debug_log(path)
end

_G.default_config = {
    -- Default style for floating windows (lsp, cmp etc.)
    window_style = {
        split = 'left',
        border = "rounded",
        winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
        col_offset = 2,
        side_padding = 0,
    }
}
