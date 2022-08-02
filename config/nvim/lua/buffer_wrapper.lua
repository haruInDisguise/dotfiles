local function new_buffer_state(tab)
    local userdata = newproxy(true);
    local table = getmetatable(userdata)

    local symbol = tab;

    table.__index = function(tabe, key)
        return key
    end
end

local buffer_wrapper = setmetatable({
    previous = {
        path = nil,
        position = nil,
    }

    current = {
        path = nil,
        position = nil,
    }

    print_msg = function(self, args)
        print("[buffer_wrapper]", args)
    end,

    save_state = function(self, state)
        state = {
            path = vim.fn.getpath(),
            line = vim.fn.getline(),
            position = vim.fn.getpos(),
        }
    end,

    close = function(self)
        if ( not (self.previous_buffer == nil) ) then
            self.previous_buffer = buffer_wrapper.current_buffer
            self.current_buffer = vim.fn.expand('%')

            self:print_msg('buffer closed: '.. self.current_buffer)

            self.current.line = vim.fn.getline()
        end
    end,

    restore = function()
        if ( not (buffer_wrapper.current_buffer == nil) ) then
            buffer_wrapper.current_buffer = vim.fn.expand('%')

            buffer_wrapper.print_msg('buffer closed: '.. buffer_wrapper.current_buffer)

            vim.fn.expand('bd')
        end
    end,

    open = function()
        buffer_wrapper.previous_buffer = current_buffer
    end,
}, {})
