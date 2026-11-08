vim.pack.add({
	{
		src = "https://github.com/lewis6991/gitsigns.nvim",
		name = "gitsigns",
	},
})

----------------------------------------------
-- Setup
----------------------------------------------
require("gitsigns").setup({
	signcolumn = true,
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
})
