vim.pack.add({
	{
		src = "https://github.com/rcarriga/nvim-notify",
		name = "notify",
	}
})

----------------------------------------------
-- Setup
----------------------------------------------
vim.notify = require("notify")
