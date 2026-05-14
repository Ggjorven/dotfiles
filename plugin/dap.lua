vim.pack.add({
	{
		src = "https://github.com/mfussenegger/nvim-dap",
		name = "dap",
	},
	{
		src = "https://github.com/theHamsta/nvim-dap-virtual-text",
		name = "dap-virtual-text",
	},
	{
		src = "https://github.com/igorlfs/nvim-dap-view",
		name = "dap-view",
	}
})

----------------------------------------------
-- Setup
----------------------------------------------
require("nvim-dap-virtual-text").setup({
})

----------------------------------------------
-- Keymaps
----------------------------------------------
vim.keymap.set("n", "<leader>dt", "<cmd>DapViewToggle<cr>", { desc = "Open debugger" })
vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<cr>", { desc = "Continue debugger" })
vim.keymap.set("n", "<leader>dw", "<cmd>DapViewWatch<cr>", { desc = "Watch variable" })
