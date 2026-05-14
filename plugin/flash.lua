vim.pack.add({
	{
		src = "https://github.com/folke/flash.nvim", 
		name = "flash",
	} 
})

----------------------------------------------
-- Commands
----------------------------------------------
require("flash").setup({
})

require("flash").toggle(true)

----------------------------------------------
-- Keymaps
----------------------------------------------
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
