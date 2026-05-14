vim.pack.add({
	{
		src = "https://github.com/neovim/nvim-lspconfig",
		name = "lspconfig"
	},
	{
		src = "https://github.com/mason-org/mason.nvim",
		name = "mason"
	},
	{
		src = "https://github.com/mason-org/mason-lspconfig.nvim",
		name = "mason-lspconfig"
	},
	{
		src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
		name = "mason-tool-installer"
	},
	{
		src = "https://github.com/saghen/blink.cmp",
		name = "blink-cmp",
		version = "v1"
	}
})

----------------------------------------------
-- Setup
----------------------------------------------
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"stylua"
	}
})
require("blink-cmp").setup({
	signature = { enabled = true },
	completion = {
		list = {
			selection = {
				preselect = true,
				auto_insert = false,  -- only inserts on explicit accept
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500
		},
    	menu = {
			auto_show = true,
      		auto_show_delay_ms = 0,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } }
			}
    	},
	},
	keymap = {
		preset = "default",
		["<CR>"]   = { "fallback" }, -- Disable enter
		["<C-CR>"] = { "accept", "fallback" },
		["<Tab>"]   = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" }
	}
})

----------------------------------------------
-- Language configurations
----------------------------------------------
-- LUA (removes vim. warning)
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			hint = { enable = true },
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					'vim',
					'require'
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

----------------------------------------------
-- Keymaps
----------------------------------------------
vim.keymap.set("n", "<leader>h", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	vim.notify(vim.lsp.inlay_hint.is_enabled() and "Inlay hints enabled" or "Inlay hints disabled")
end)
