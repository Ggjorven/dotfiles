-- Renaming a buffer/file 
vim.api.nvim_create_user_command("Rename", function(opts)
	local oldName = vim.api.nvim_buf_get_name(0)
	local newName = opts.args
 
	if oldName == "" then
		print("Buffer has no name")
		return
	end
	
	local Path = require("plenary.path")
	local oldPath = Path:new(current)
	local newPath = old_path:parent():joinpath(opts.args)

	os.rename(old_path:absolute(), new_path:absolute())

	vim.cmd("edit " .. newName)
	vim.cmd("bwipeout " .. oldName)
end, { nargs = 1, complete = "file" })
