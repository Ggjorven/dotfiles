vim.pack.add({
	{
		src = "https://github.com/greggh/claude-code.nvim",
		name = "claude-code"
	}
})

----------------------------------------------
-- Setup
----------------------------------------------
require("claude-code").setup({
	window = {
		split_ratio = 0.5,
		position = "float",
		enter_insert = true,
	},

	command = "claude",        -- Command used to launch Claude Code
	
	keymaps = {
		toggle = {
			normal = false,
			terminal = false,
		},

		window_navigation = true,
		scrolling = true,
	}
})

----------------------------------------------
-- Keymaps
----------------------------------------------
vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code" })

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*claude*",
	callback = function()
		-- Single Esc passes through (e.g. to fzf, lazygit, etc.)
		vim.keymap.set("t", "<Esc>", "<Esc>", { noremap = true, silent = true, buffer = true })
		-- Double Esc exits terminal mode
		vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true, buffer = true })

		-- Toggleterm like keymap to close
		vim.keymap.set("t", "<C-\\>", function()
			vim.api.nvim_feedkeys(
			vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
			vim.schedule(function()
				vim.cmd("ClaudeCode")
			end)
		end, { noremap = true, silent = true, buffer = true })
  end,
})
