local lualine = {}

---------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------
function lualine.lualine()
    require('lualine').setup({
        options = {
            icons_enabled = false,
            theme = require("plugins.colourscheme").theme,
            component_separators = '|',
            section_separators = '',
        },
    })
end

---------------------------------------------------------------------------
-- Logic
---------------------------------------------------------------------------
function lualine.finish()
    vim.opt.showmode = false
end

return lualine