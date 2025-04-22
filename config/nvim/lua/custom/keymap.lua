-- Keymaps for my vim configuration! WOW

-- TODO: Decide if registration method is
-- overdone trash or actually makes things
-- more readable and use it somewhere else.

local utils = require('custom.utils')

local map_options = { noremap = true }
local register_key = utils.keymap.get_func_with_config(map_options)

register_key({ "n", "c", "v", "x", "i" }, "<c-j>", "<esc>", { desc = "Remapped escape" })
register_key("n", "<leader><leader>", "<c-^>", { desc = "Switch to the previous buffer" })

register_key("n", "<leader>y", '"+y', { desc = "Yank into secondary clipboard (+)" })
register_key("n", "<leader>p", '"0p', { desc = "Paste yanked text" })

-- Buffer
register_key("n", "<c-h>", "<cmd>nohlsearch<cr>", { desc = "Turn of search match highlighting" })

register_key("n", "<leader>w", "<cmd>write<cr>", { desc = "Write active buffer to disk" })
register_key("n", "<leader>W", "<cmd>w !sudo tee % >/dev/null<CR>", { desc = "Write active buffer as root" })

register_key("n", "ycc", "yygcc", { desc = "Yank commented lines", remap = true })

-- Movement
register_key("n", "n", "nzz", { desc = "Move to the next highlighted item" })
register_key("n", "N", "Nzz", { desc = "Move to the previous highlighted item" })

register_key("n", "H", "Hzz", { desc = "Move to first displayed line" })
register_key("n", "M", "Mzz", { desc = "Move to middle displayed line" })
register_key("n", "L", "Lzz", { desc = "Move to last displayed line" })

register_key("n", "[[", "[[zz", { desc = "[count] sections backward" })
register_key("n", "]]", "]]zz", { desc = "[count] sections forward" })

-- Set the context marker for large jumps
local mark_jump = function(key, count)
    -- FIXME: Find a way to clear v:count without
    -- relying on [[ m" ]]
    local sequence = ""
    if vim.v.count1 >= count then
        sequence = sequence .. [[m']] .. vim.v.count1
    end
    print(sequence .. key)
    return sequence .. key
end

register_key("n", "j", function()
    return mark_jump("gj", 6)
end, { desc = "Down. Sets context mark for [count] > 6", expr = true })
register_key("n", "k", function()
    return mark_jump("gk", 6)
end, { desc = "Up. Sets context mark for [count] > 6", expr = true })
