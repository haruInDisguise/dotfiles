-- Configuration for nvim-compe: https://github.com/hrsh7th/nvim-compe#features
local compe = require 'compe'
local config = {}

local init = function()
    compe.setup({
        enabled = true;
        autocomplete = true;
        debug = false;
        lin_length = 1;
        preselect = 'enable';
        throttle_time = 80;
        source_timeout = 200;
        resolve_timeout = 800;
        incomplete_delay = 400;
        max_abbr_width = 100;
        max_kind_width = 100;
        max_menu_width = 100;
        documentation = {
            border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
            winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
            max_width = 120,
            min_width = 60,
            max_height = math.floor(vim.o.lines * 0.3),
            min_height = 1,
        };

        source = {
            path = true;
            buffer = true;
            calc = true;
            nvim_lsp = true;
            nvim_lua = true;
            -- vsnip = true;
            -- ultisnips = true;
            -- luasnip = true;
        };
    })

    -- Setup default keymap completions
    local set_keymap = vim.api.nvim_set_keymap
    local keymap_options = {
        silent = true,
        expr = true,
    }
    
    set_keymap('i', '<C-Space>', 'compe#complete()', keymap_options)
    set_keymap('i', '<C-e>', "compe#close('<C-e>')", keymap_options)
    set_keymap('i', '<C-f>', "compe#scroll({ 'delta': +4 })", keymap_options)
    set_keymap('i', '<C-d>', "compe#scroll({ 'delta': -4 })", keymap_options)
end

init()

