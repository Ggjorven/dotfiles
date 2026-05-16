vim.pack.add({
	{
		src = "https://github.com/OXY2DEV/markview.nvim",
		name = "markview"
	}
})

----------------------------------------------
-- Setup
----------------------------------------------
require("markview").setup({
	preview = {
		enable = false
	}
});
