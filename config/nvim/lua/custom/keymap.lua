-- Keymaps for my vim configuration! WOW

-- TODO: Decide if registration method is
-- overdone trash or actually makes things
-- more readable and use it somewhere else.

local M = {}
local map_options = { noremap = true }

---@class custom.KeymapMapping: vim.keymap.set.Opts
---@field [1] string|function

---@alias custom.KeyMap table<string, table<string, string|function|custom.KeymapMapping>>

---@param map custom.KeyMap
M.register_keymap = function(map, default_config)
    for rawmode, items in pairs(map) do
        for lhs, rawrhs in pairs(items) do
            local rhs = type(rawrhs) == "table" and table.remove(rawrhs, 1) or rawrhs
            local config = type(rawrhs) == "table" and rawrhs or {}
            local mode = rawmode == "" and {"n", "i", "v", "x"} or rawmode

            -- vim.notify(string.format("Registering keymap for mode '%s': %s => %s", mode, lhs, vim.inspect(rhs)), vim.log.levels.DEBUG)
            -- vim.notify(string.format("Config: %s", vim.inspect(config)), vim.log.levels.DEBUG)

            ---@diagnostic disable-next-line: param-type-mismatch
            vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend("keep", config, default_config))
        end
    end
end

-- Set the context marker for large jumps
local mark_jump = function(key)
    -- FIXME: Find a way to clear v:count without
    -- relying on [[ m" ]]
    local sequence = ""
    if vim.v.count1 >= 8 then
        sequence = sequence .. [[m"]] .. vim.v.count1
    end
    return sequence .. key
end

---@type custom.KeyMap
local default_keymap = {
    [""] = {
        -- Remap escape for all modes
        ["<C-k>"] = "<nop>",
        ["<C-j>"] = "<esc>",
    },

    ["n"] = {
        -- switch to prev, next buffer
        ["<leader><leader>"] = "<c-^",
        ["<leader>d"] = "<cmd>bd<cr>zz",

        -- yank into secondary clipboard
        ["<leader>y"] = '"+y',
        ["<leader>p"] = '"0p',

        -- "de-highlight"
        ["<c-h>"] = "<cmd>nohlsearch<cr>",

        -- Save file
        ["<leader>w"] = "<cmd>w<CR>",
        ["<leader>W"] = "<cmd>w !sudo tee % >/dev/null<CR>",

        -- center moves/jumps
        -- vim.keymap.set("n", [[""]], [[""zz]])
        ["n"] = "nzz",
        ["N"] = "Nzz",

        ["H"] = "Hzz",
        ["M"] = "Mzz",
        ["L"] = "Lzz",

        ["[["] = "[[zz",
        ["]]"] = "]]zz",

        ["j"] = {
            function()
                return mark_jump("gj")
            end,

            expr = true,
        },
        ["k"] = {
            function()
                return mark_jump("gk")
            end,

            expr = true,
        }
    },
}

M.register_keymap(default_keymap, map_options)

