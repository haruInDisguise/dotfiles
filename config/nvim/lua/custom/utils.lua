-- LSP Debugging
vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({ "ERROR", "WARN", "INFO", "DEBUG" })[result.type]

    if client then
        print(result.message, lvl, {
            title = "LSP | " .. client.name,
            timeout = 10000,
            keep = function()
                return lvl == "ERROR" or lvl == "WARN"
            end,
        })
    end
end

function _G.debug_ts()
    local node = vim.treesitter.get_node({
        bufnr = 0,
    })
    assert(node)

    vim.treesitter.get_parser(0):for_each_tree(function(tree, ltree)
        local lines = {}

        local function walk_tree(root)
            for node, _ in root:root():iter_children() do
                local name_nodes = node:field("name")

                for _, n in ipairs(name_nodes) do
                    local name = vim.treesitter.get_node_text(n, 0)
                    print(name)
                    table:insert(lines, name)
                end

                walk_tree(node)
            end
        end

        walk_tree(tree:root())
        debug_dump(lines)
    end)

    -- local node_text = vim.treesitter.get_node_text(node, 0, {})
    -- vim.notify(string.format("type=%s\ntext=%s", node:type(), node_text))
end

vim.keymap.set("n", "<leader>x", function()
    debug_ts()
end, {})

function _G.debug_dump(obj)
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

_G.default_config = {
    -- Default style for floating windows (lsp, cmp etc.)
    window_style = {
        border = "rounded",
        winhighlight = "Normal:DarkBlue,FloatBorder:Normal,CursorLine:Visual,Search:None",
    }
}
