function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
    return ...
end

_G.default_config = {
    -- Default style for floating windows (lsp, cmp etc.)
    window_style = {
        border = "rounded",
        winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
        zindex = 1001,
        col_offset = 2,
        side_padding = 1,
        scrollbar = true,
    }
}
