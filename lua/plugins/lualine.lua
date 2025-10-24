vim.opt.showmode = false
require('lualine').setup({
  options = {
    icons_enabled = false,
    theme = require("plugins.colorscheme"),
    component_separators = '|',
    section_separators = '',
  },
})