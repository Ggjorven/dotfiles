vim.pack.add({
	{
		src = "https://github.com/nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		src = "https://github.com/nvim-telescope/telescope.nvim",
		name = "telescope",
		version = "v0.2.2",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim"
		}
	},
	{
		src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
		name = "telescope-fzf-native"
	}
})

----------------------------------------------
-- Keymaps
----------------------------------------------
local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", function()
  local ok = pcall(telescope.git_files)
  if not ok then
    telescope.find_files()
  end
end, { desc = "Telescope git/find files" })

vim.keymap.set("n", "<leader>fF", telescope.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fs", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    telescope.lsp_workspace_symbols({ symbols = { "function", "method", "class", "struct", "enum" } })
  else
    telescope.treesitter()
  end
end, { desc = "Telescope symbols" })
vim.keymap.set("n", "<leader>fn", function()
	require('telescope').extensions.notify.notify()
end, { desc = "Telescope notifications" })
