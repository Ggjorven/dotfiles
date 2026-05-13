vim.pack.add({
	-- {
	-- 	src = "https://github.com/rose-pine/neovim",
	-- 	name = "rose-pine"
	-- }
	{
		src = "https://github.com/navarasu/onedark.nvim",
		name = "onedark"
	}
	-- {
	-- 	src = "https://github.com/Mofiqul/vscode.nvim",
	-- 	name = "vscode"
	-- }
	-- {
	-- 	src = "https://github.com/Mofiqul/dracula.nvim",
	-- 	name = "dracula"
	-- }
	-- {
	-- 	src = "https://github.com/luisiacc/gruvbox-baby",
	-- 	name = "gruvbox-baby"
	-- }
	-- {
	-- 	src = "https://github.com/samharju/synthweave.nvim",
	-- 	name = "synthweave"
	-- }
})

----------------------------------------------
-- Setup
----------------------------------------------
-- require("rose-pine").setup({
-- 	variant = "moon"
-- })

require("onedark").setup({
    style = "warmer" -- or darker
})

-- require("vscode").setup({
-- 	style = "dark"
-- })

-- require("dracula").setup({
-- })

-- No gruvbox-baby setup

-- require("synthweave").setup({
-- })

----------------------------------------------
-- Commands
----------------------------------------------
-- vim.cmd.colorscheme("rose-pine")
vim.cmd.colorscheme("onedark")
-- vim.cmd.colorscheme("vscode")
-- vim.cmd.colorscheme("dracula")
-- vim.cmd.colorscheme("gruvbox-baby")
-- vim.cmd.colorscheme("synthweave")
