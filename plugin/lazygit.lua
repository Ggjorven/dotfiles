vim.pack.add({
	{
		src = "https://github.com/nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		src = "https://github.com/kdheepak/lazygit.nvim",
		name = "lazygit",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	}
})

----------------------------------------------
-- Keymaps
----------------------------------------------
vim.keymap.set("n", "<leader>'", "<cmd>LazyGit<cr>", { desc = "Open Lazygit" })
