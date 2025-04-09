function _G.debug_dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
    return ...
end

function _G.put_text(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  local lines = vim.split(table.concat(objects, '\n'), '\n')
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  vim.fn.append(lnum, lines)
  return ...
end

_G.default_config = {
    -- Default style for floating windows (lsp, cmp etc.)
    window_style = {
        border = "rounded",
        winhighlight = 'Normal:DarkBlue,FloatBorder:Normal,CursorLine:Visual,Search:None',
    }
}
