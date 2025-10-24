local neoterm = require("neoterm")

neoterm.setup({
  clear_on_run = true, -- Run clear command before user specified commands
  position = 'right',  -- Position of the terminal window: fullscreen (0), top (1), right (2), bottom (3), left (4), center (5) (string or integer value)
  noinsert = false,    -- Disable entering insert mode when opening the neoterm window
  width = 0.2,         -- Width of the terminal window (percentage, ratio, or range between 0-1)
  height = 0.2,          -- Height of the terminal window (percentage, ratio, or range between 0-1)
})

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]])
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]])
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])

vim.keymap.set("n", "<leader>a", [[]])

-- Add this to your init.lua or a plugin file
vim.api.nvim_create_user_command("T", function(opts)
	neoterm.toggle()

	if opts.args ~= "" then
		neoterm.run(opts.args, { clear = false })
	end

end, {
  nargs = "*", -- allow optional arguments
  desc = "My custom Neoterm :T command",
})

vim.api.nvim_create_autocmd("TermLeave", { callback = function()
	  neoterm.toggle()
    end
})

-- Automatically enable word wrap in NeoTerm buffers
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function(args)
    -- Check if it's a NeoTerm buffer specifically
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    if bufname:match("term://.*:NeoTerm") then
      vim.opt_local.wrap = true
    end
  end,
})
  -- Note: This makes it be open in the background for easy switching
neoterm.open({ noinsert = true })
neoterm.close()
