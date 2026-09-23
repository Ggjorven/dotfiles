vim.pack.add({
	{
		src = "https://github.com/nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		src = "https://github.com/nvim-telescope/telescope.nvim",
		name = "telescope",
		version = "v0.2.2",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim"
		}
	},
	{
		src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
		name = "telescope-fzf-native",
		build = "make",
	}
})

----------------------------------------------
-- Setup
----------------------------------------------
local telescope_config = require("telescope")

local file_ranks = {
    cpp = 1, c = 1, h = 1, hpp = 1, m = 1, mm = 1, cc = 1, cxx = 1, hxx = 1, rs = 1, cs = 1, java = 1, hs = 1,
    lua = 2, py = 2, sh = 2, bash = 2,
    md = 3,
}

local function tiebreak(current_entry, existing_entry, _)
    local c_path = current_entry.path or current_entry.filename or current_entry.value or ""
    local e_path = existing_entry.path or existing_entry.filename or existing_entry.value or ""

    local c_ext = c_path:match("%.([^%.]+)$")
    local e_ext = e_path:match("%.([^%.]+)$")

    local c_rank = c_ext and file_ranks[c_ext] or 4
    local e_rank = e_ext and file_ranks[e_ext] or 4

    if c_rank ~= e_rank then
        return c_rank < e_rank
    end

    -- Fallback: short path wins (default behaviour)
    return #c_path < #e_path
end

-- 3. Apply the tiebreak and load extensions
telescope_config.setup({
    defaults = {
        tiebreak = tiebreak,
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
})

telescope_config.load_extension("fzf")
telescope_config.load_extension("notify")

----------------------------------------------
-- Keymaps
----------------------------------------------
local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>fF", function()
  local ok = pcall(telescope.git_files)
  if not ok then
    telescope.find_files()
  end
end, { desc = "Telescope git/find files" })

vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fs", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    telescope.lsp_workspace_symbols({ symbols = { "function", "method", "class", "struct", "enum" } })
  else
    telescope.treesitter()
  end
end, { desc = "Telescope symbols" })
vim.keymap.set("n", "<leader>fd", function()
	telescope.diagnostics({
		severity = { min = vim.diagnostic.severity.INFO }
	})
end, { desc = "Telescope diagnostics" })
vim.keymap.set("n", "<leader>fn", "<cmd>Telescope notify<cr>", { desc = "Telescope notifications" })
