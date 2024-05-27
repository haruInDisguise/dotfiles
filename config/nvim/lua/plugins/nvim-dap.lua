-- config for: https://github.com/mfussenegger/nvim-dap

return {
    'mfussenegger/nvim-dap',
    config = function(_)
        local dap = require('dap')

        local config_codelldb = {
            type = 'codelldb',
            request = 'launch',
            name = 'Launch codelldb to debug rust programs',
        }

        dap.configurations.rust = config_codelldb
    end,
}
