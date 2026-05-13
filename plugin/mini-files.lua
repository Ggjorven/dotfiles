vim.pack.add({
	{
		src = "https://github.com/nvim-mini/mini.files", 
		name = "mini-files", 
		version = "stable"
	} 
})

----------------------------------------------
-- Setup
----------------------------------------------
require("mini.files").setup({
	-- General options
	options = {
		use_as_default_explorer = true,
	},

	-- Customization of explorer windows
	windows = {
		preview = false,
		width_focus = 50,
		width_nofocus = 15,
		width_preview = 25,
	},
})

----------------------------------------------
-- Keymaps
----------------------------------------------
vim.keymap.set("n", "<leader>e", function()
	require("mini.files").open()
end, { desc = "Open MiniFiles" })

vim.keymap.set("n", "<leader>E", function()
    local buf_dir = vim.fn.expand("%:p:h") -- get current buffer"s directory
    require("mini.files").open(buf_dir)
end, { desc = "Open MiniFiles at current buffer directory" })
