local M = {
    debug = {},
    keymap = {},
    buffer = {},
}

M.buffer.close = function()
    local current_buffer = nil
end

-- Define some global debugging primitives
function M.debug.show_help_for_tag(tag)
    local success = pcall(vim.cmd.help, { args = { tag } })
    if not success then
        print("No help for tag: " .. tag)
    end
end

function M.debug.get_named_item_at_pos()
    local node = vim.treesitter.get_node({})
    assert(node, "Failed to query treesitter node")
    -- vim.api.nvim_echo({{"Hello there!", "@keyword.repeat.lua"}})

    local target_nodes = node:field("name")
    while #target_nodes == 0 do
        node = node:parent()
        if not node then
            -- print("Reached tree root")
            return
        end

        target_nodes = node:field("name")
    end

    return vim.treesitter.get_node_text(target_nodes[1], 0)
end

function M.debug.dump_ts()
    local parser = vim.treesitter.get_parser()
    if not parser then
        return
    end

    local lang = parser:lang()
    local query = vim.treesitter.query.parse(lang,
        [[
    (_ name: (_) @vim_api_func
        (#match? @vim_api_func "vim"))
    ]]
    )

    local trees = parser:trees()
    assert(trees)

    local match_list = {}

    for _, tree in ipairs(trees) do
        for id, node, metadata, match in query:iter_captures(tree:root(), 0) do
            match:info()
            local name = vim.treesitter.get_node_text(node, 0)
            table.insert(match_list, name)
        end
    end

    vim.notify(table.concat(match_list, '\n'))
end

function M.debug.dump(obj)
    local raw_dump = vim.inspect(obj)

    local text = vim.split(raw_dump, '\n')
    local buffer = vim.api.nvim_create_buf(false, true)
    if buffer == 0 then
        return
    end

    vim.api.nvim_buf_set_lines(buffer, 0, #text, false, text)
    vim.api.nvim_set_option_value("modifiable", false, {
        buf = buffer,
        scope = "local",
    })
    vim.api.nvim_buf_set_keymap(buffer, "n", "q", "", {
        callback = function()
            vim.api.nvim_buf_delete(buffer, { force = true, })
        end,
    })
    vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), buffer)
end

---@param default_config vim.keymap.set.Opts
M.keymap.get_func_with_config = function(default_config)
    ---@param mode string|string[]
    ---@param lhs string
    ---@param rhs string|function
    ---@param opts? vim.keymap.set.Opts
    return function(mode, lhs, rhs, opts)
        local config = vim.tbl_extend("force", default_config, opts)
        vim.keymap.set(mode, lhs, rhs, config)
    end
end

return M
