local telescope = {}

-- Note: Case insensitive
local excludedDirectories = {
	"vendor",
	"third-party",
	"thirdparty",
}

---------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------
function telescope.telescope()
    require('telescope').setup({
		defaults = {
			vimgrep_arguments = {
			  "rg",
			  "--color=never",
			  "--no-heading",
			  "--with-filename",
			  "--line-number",
			  "--column",
			  "--smart-case",
			  -- "--ignore-file", ".gitignore"  -- explicitly read .gitignore
			},
		},
    })
end

---------------------------------------------------------------------------
-- Logic
---------------------------------------------------------------------------
function cppGetCompiledAndHeaderFiles()
  	local json = vim.fn.json_decode
	local path = vim.fn.getcwd() .. "/compile_commands.json"

  	if vim.fn.filereadable(path) == 0 then return {} end

  	local data = vim.fn.readfile(path)
  	local jsonData = json(table.concat(data, "\n"))
  	local files = {}
  	
	for _, entry in ipairs(jsonData) do
    	table.insert(files, entry.file)
    	
		local header = entry.file:gsub("%.%w+$", ".h")
    	table.insert(files, header)

    	local headerpp = entry.file:gsub("%.%w+$", ".hpp")
    	table.insert(files, headerpp)
  	end
  	
	return files
end

local function isExcluded(path)
    local lower = path:lower()  -- normalize for case-insensitive matching

    for _, dir in ipairs(excludedDirectories) do
        if lower:match("^" .. vim.pesc(dir:lower()) .. "/") then
            return true
        end
    end

    return false
end

function cppGetProjectCompiledAndHeaderFiles()
	local allFiles = cppGetCompiledAndHeaderFiles() 
 	local files = {}
	local cwd = vim.fn.getcwd() .. "/"  

	print(cwd)
	print(isExcluded("Vendor/"))
	print(isExcluded("/Vendor/"))
	print(isExcluded("vendor/"))
	print(isExcluded("/vendor/"))

	for _, entry in ipairs(allFiles) do
		local relative = entry:gsub("^" .. vim.pesc(cwd), "") 
		print(entry)
		print(relative)
		print(isExcluded(relative))
		break

		-- if not isExcluded(relative) then
		-- 	table.insert(files, entry)
		-- end
	end

	return files
end

function telescope.finish()
    vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
    vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
    vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})
    vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})

--	local f = io.open("nvim_debug.log", "a")  -- append mode
--    if f then
--        f:write(vim.inspect(cppGetProjectCompiledAndHeaderFiles()) .. "\n")
--        f:close()
--    end
end

return telescope
