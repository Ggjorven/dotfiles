vim.pack.add({
	{
		src = "https://github.com/jake-stewart/multicursor.nvim",
		name = "multicursor",
	},
})

----------------------------------------------
-- Commands
----------------------------------------------
require("multicursor-nvim").setup({})

----------------------------------------------
-- Keymaps
----------------------------------------------
local mc = require("multicursor-nvim")

-- Add and remove cursors with ctrl + left click.
vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)
vim.keymap.set("n", "<c-leftdrag>", mc.handleMouseDrag)
vim.keymap.set("n", "<c-leftrelease>", mc.handleMouseRelease)

-- Disable and enable cursors // TODO: Fix v-block
vim.keymap.set({ "n", "x" }, "<c-q>", mc.toggleCursor)
