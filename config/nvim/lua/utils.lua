-- Some utility and maintenance stuff. 

local utils = {}

-- Define convenient things in the global namespace

-- Pretty print lua objects
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
    return ...
end

local init = function()

end

init()
