local files = {}

---------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------
function files.mini()
    require('mini.files').setup({
		options = {
			use_as_default_explorer = true,
		},
    })
end

---------------------------------------------------------------------------
-- Logic
---------------------------------------------------------------------------
function files.finish()
    vim.keymap.set('n', '<leader>e', function()
		require("mini.files").open()
	end, { desc = "Open MiniFiles" })

	vim.keymap.set("n", "<leader>E", function()
      local buf_dir = vim.fn.expand("%:p:h") -- get current buffer's directory
      require("mini.files").open(buf_dir)
    end, { desc = "Open MiniFiles at current buffer directory" })
end

return files
