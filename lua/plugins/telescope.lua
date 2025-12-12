local telescope = {}

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

function telescope.fzf()
	require('telescope').load_extension("fzf")
end

---------------------------------------------------------------------------
-- Logic
---------------------------------------------------------------------------
function telescope.finish()
    vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
    vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
    vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})
    vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})
end

return telescope
