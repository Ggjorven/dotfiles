vim.pack.add{
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
	}
}

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

----------------------------------------------
-- Setup
----------------------------------------------
-- LUA (removes vim. warning)
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
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
