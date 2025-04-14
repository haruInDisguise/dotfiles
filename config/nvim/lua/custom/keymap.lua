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
            local mode = rawmode == "" and { "n", "i", "v", "x" } or rawmode

            -- vim.notify(string.format("Registering keymap for mode '%s': %s => %s", mode, lhs, vim.inspect(rhs)), vim.log.levels.DEBUG)
            -- vim.notify(string.format("Config: %s", vim.inspect(config)), vim.log.levels.DEBUG)

            ---@diagnostic disable-next-line: param-type-mismatch
            vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend("keep", config, default_config))
        end
    end
end

-- Set the context marker for large jumps
local mark_jump = function(key, count)
    -- FIXME: Find a way to clear v:count without
    -- relying on [[ m" ]]
    local sequence = ""
    if vim.v.count1 >= count then
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
        ["<leader><leader>"] = { "<c-^", desc = "Switch to the previous buffer" },
        ["<leader>d"] = { "<cmd>bd<cr>zz", desc = "Close the active buffer" },

        -- yank into secondary clipboard
        ["<leader>y"] = { '"+y', desc = "Yank into system secondary clipboard (+)" },
        ["<leader>p"] = { '"0p', desc = "Paste yanked text" },

        -- "de-highlight"
        ["<c-h>"] = { "<cmd>nohlsearch<cr>", desc = "Stop text highlighting" },

        -- Save file
        ["<leader>w"] = { "<cmd>w<CR>", desc = "Write active buffer" },
        ["<leader>W"] = { "<cmd>w !sudo tee % >/dev/null<CR>", desc = "Write active buffer as root" },

        -- center moves/jumps
        -- vim.keymap.set("n", [[""]], [[""zz]])
        ["n"] = { "nzz", desc = "Move to the next highlighted item" },
        ["N"] = { "Nzz", desc = "Move to the previous highlighted item" },

        ["H"] = { "Hzz", desc = "Move to first displayed line" },
        ["M"] = { "Mzz", desc = "Move to middle displayed line" },
        ["L"] = { "Lzz", desc = "Move to last displayed line" },

        ["[["] = { "[[zz", desc = "[count] sections backward" },
        ["]]"] = { "]]zz", desc = "[count] sections forward" },

        ["j"] = {
            function()
                return mark_jump("gj", 6)
            end,

            desc = "[count] lines down. Sets context mark for [count] > 6",
            expr = true,
        },
        ["k"] = {
            function()
                return mark_jump("gk", 6)
            end,

            desc = "[count] lines up. Sets context mark for [count] > 6",
            expr = true,
        }
    },
}

M.register_keymap(default_keymap, map_options)
