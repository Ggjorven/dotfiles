vim.pack.add({
	{
		src = "https://github.com/mason-org/mason.nvim",
		name = "mason"
	},
	{
		src = "https://github.com/mason-org/mason-lspconfig.nvim",
		name = "mason-lspconfig"
	},
	-- {
	-- 	src = "jay-babu/mason-nvim-dap.nvim",
	-- 	name = "mason-dap"
	-- },
	{
		src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
		name = "mason-tool-installer"
	}
})

----------------------------------------------
-- Setup
----------------------------------------------
require("mason").setup()
require("mason-lspconfig").setup()
-- require('mason-nvim-dap').setup({
-- 	ensure_installed = { "cppdbg", "codelldb" },
-- 	automatic_installation = true,
-- 	handlers = {
-- 		function(config)
-- 			require("mason-nvim-dap").default_setup(config)
-- 		end,
-- 	},
-- })
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"stylua",

		-- Requires node and npm/x
		"pyright",
		"debugpy",

		"codelldb",
		"clangd",
		"cpptools",
		-- "cmake-language-server", -- Requires python <= 3.14

		-- Requires dotnet (10)
		"csharp-language-server",
		"netcoredbg",
		-- TODO: Blazor

		"sqlls",

		-- Requires node and nvpm
		"html-lsp",
		"css-lsp",

		-- Requires ghcup
		-- Optional: cabal install ormolu for auto tabs to spaces
		"haskell-language-server",
		-- "haskell-debug-adapter", -- FAILED to build

		-- Requires rustup with rustfmt (nightly)
		"rust-analyzer",

		-- Requires java sdk (21+)
		"jdtls",
		"java-debug-adapter",
		"java-test",
	}
})
