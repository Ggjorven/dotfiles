vim.pack.add({
	{
		src = "https://github.com/nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		src = "https://github.com/nvim-pack/nvim-spectre",
		name = "spectre",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	}
})

----------------------------------------------
-- Commands
----------------------------------------------
require("spectre").setup({
})

----------------------------------------------
-- Keymaps
----------------------------------------------
local spectre = require("spectre")

vim.keymap.set("n", "<leader>s", spectre.toggle, { desc = "Toggle Spectre" })
-- vim.keymap.set("n", "<leader>sw", function() spectre.open_visual({ select_word=true }) end, { desc = "Search current word" })
vim.keymap.set("n", "<leader>ss", function() spectre.open_visual() end, { desc = "Search selection" })
