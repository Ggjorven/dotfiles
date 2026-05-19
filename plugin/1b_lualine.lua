vim.pack.add({
	{
		src = "https://github.com/nvim-tree/nvim-web-devicons",
		name = "web-devicons",
	},
	{
		src = "https://github.com/nvim-lualine/lualine.nvim",
		name = "lualine",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	}
})

----------------------------------------------
-- Port colortheme
----------------------------------------------
local function hl(name, attr)
  local ok, group = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if ok and group[attr] then
    return string.format("#%06x", group[attr])
  end
end

local theme = {
  normal = {
    a = { fg = hl("Normal",    "bg"), bg = hl("Function",  "fg"), gui = "bold" },
    b = { fg = hl("Normal",    "fg"), bg = hl("StatusLine", "bg") },
    c = { fg = hl("Comment",   "fg"), bg = hl("Normal",     "bg") },
  },
  insert  = { a = { fg = hl("Normal", "bg"), bg = hl("String",    "fg"), gui = "bold" } },
  visual  = { a = { fg = hl("Normal", "bg"), bg = hl("Special",   "fg"), gui = "bold" } },
  replace = { a = { fg = hl("Normal", "bg"), bg = hl("Constant",  "fg"), gui = "bold" } },
  command = { a = { fg = hl("Normal", "bg"), bg = hl("Identifier","fg"), gui = "bold" } },
  inactive = {
    c = { fg = hl("Comment", "fg"), bg = hl("Normal", "bg") },
  },
}

----------------------------------------------
-- Setup
----------------------------------------------
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = theme,
		component_separators = { left = "", right = ""},
		section_separators = { left = "", right = ""},
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
	always_divide_middle = true,
	always_show_tabline = true,
	globalstatus = false,
	},
	sections = {
		lualine_a = {"mode"},
		lualine_b = {"branch"},
		lualine_c = {},
		lualine_x = {"diff", "diagnostics", "filename"},
		lualine_y = {},
		lualine_z = {}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {"filename"},
		lualine_y = {},
		lualine_z = {}
	},
})

vim.o.showmode = false
