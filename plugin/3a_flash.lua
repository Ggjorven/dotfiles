vim.pack.add({
	{
		src = "https://github.com/folke/flash.nvim",
		name = "flash",
	}
})

----------------------------------------------
-- Setup
----------------------------------------------
require("flash").setup({
	modes = {
		char = {
			enabled = true,
			keys = {}, -- Disabled f/F, t/T & ;/,
		}
	}
})

----------------------------------------------
-- Commands
----------------------------------------------
require("flash").toggle(true)

----------------------------------------------
-- Keymaps
----------------------------------------------
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
