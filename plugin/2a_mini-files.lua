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
local function open_minifiles(dir)
    if vim.bo.filetype == "minifiles" then return end
    require("mini.files").open(dir, false) -- false, don't restore cached state
end

vim.keymap.set("n", "<leader>e", function()
    local path = vim.fn.expand("%:p:h")
    if path == "" or vim.fn.isdirectory(path) == 0 then
        path = vim.fn.getcwd()
    end
    open_minifiles(path)
end, { desc = "Open MiniFiles at current buffer directory" })

vim.keymap.set("n", "<leader>E", function()
    open_minifiles()
end, { desc = "Open MiniFiles" })
