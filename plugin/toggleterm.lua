vim.pack.add({
	{
		src = "https://github.com/akinsho/toggleterm.nvim",
		name = "toggleterm",
	},
})

----------------------------------------------
-- Setup
----------------------------------------------
require("toggleterm").setup({
	open_mapping = [[<C-\>]],
	direction = "float",
})
