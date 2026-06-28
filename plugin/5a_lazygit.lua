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

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*lazygit*",
	callback = function()
		-- Single Esc passes through
		--  vim.keymap.set("t", "<Esc>", "<Esc>", { noremap = true, silent = true, buffer = true })
		-- Double Esc exits terminal mode
		-- vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true, buffer = true })

		-- Toggleterm like keymap to close
		vim.keymap.set("t", "<C-\\>", "<cmd>bdelete!<CR>", { noremap = true, silent = true, buffer = true })
  end,
})
