vim.pack.add({
	{
		src = "https://github.com/neovim/nvim-lspconfig",
		name = "lspconfig"
	},
	{
		src = "https://github.com/saghen/blink.cmp",
		name = "blink-cmp",
		version = "v1"
	},
	{
		src = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		name = "lsp-lines"
	},
	{
		src = "https://github.com/L3MON4D3/LuaSnip",
		name = "luasnip"
	},
	{
		src = "https://github.com/rafamadriz/friendly-snippets",
		name = "friendly-snippets"
	}
})

----------------------------------------------
-- Setup
----------------------------------------------
require("blink-cmp").setup({
	signature = { enabled = true },
	completion = {
		list = {
			selection = {
				preselect = true,
				auto_insert = false, -- only inserts on explicit accept
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
	snippets = {
		preset = "luasnip", -- hands snippet control to luasnip
	},
	keymap = {
		preset = "default",
		["<CR>"] = { "fallback" }, -- Disable enter
		["<C-CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<C-l>"] = { "snippet_forward", "fallback" }
	}
})
vim.lsp.inlay_hint.enable(true)
require("lsp_lines").setup()
require("lsp_lines").toggle()
vim.diagnostic.config({ virtual_lines = true })
require("luasnip.loaders.from_vscode").lazy_load()

----------------------------------------------
-- Language configurations
----------------------------------------------
-- LUA (removes vim. warning)
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			hint = { enable = true },
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim", "require" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
})

-- PYTHON (mason: pyright)
vim.lsp.config("pyright", {
	settings = {
		python = {
			analysis = {
				inlayHints = {
					variableTypes        = true,
					functionReturnTypes  = true,
					callArgumentNames    = true,
					pytestParameters     = true,
				},
			},
		},
	},
})

-- C / C++ (mason: clangd)
vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--fallback-style=llvm",
	},
	init_options = {
		usePlaceholders      = true,
		completeUnimported   = true,
		clangdFileStatus     = true,
	},
	-- Inlay hints are native in clangd 14+; toggled via vim.lsp.inlay_hint
	settings = {
		clangd = {
			InlayHints = {
				Enabled         = true,
				ParameterNames  = true,
				DeducedTypes    = true,
				Designators     = true,
			},
		},
	},
})

-- C# (mason: csharp-language-server)
vim.lsp.config("csharp_ls", {
	settings = {
		["csharp|inlay_hints"] = {
			csharp_enable_inlay_hints_for_implicit_object_creation    = true,
			csharp_enable_inlay_hints_for_implicit_variable_types     = true,
			csharp_enable_inlay_hints_for_lambda_parameter_types      = true,
			csharp_enable_inlay_hints_for_types                       = true,
			dotnet_enable_inlay_hints_for_indexer_parameters          = true,
			dotnet_enable_inlay_hints_for_literal_parameters          = true,
			dotnet_enable_inlay_hints_for_object_creation_parameters  = true,
			dotnet_enable_inlay_hints_for_other_parameters            = true,
			dotnet_enable_inlay_hints_for_parameters                  = true,
			dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix  = true,
			dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name    = true,
			dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent    = true,
		},
	},
})

-- SQL (mason: sqlls)
vim.lsp.config("sqlls", {
	-- sqlls picks up connection config from .sqllsrc.json in your project root
	settings = {},
})

-- HTML (mason: html-lsp)
vim.lsp.config("html", {
	settings = {
		html = {
			format   = { enable = true },
			hover    = { documentation = true, references = true },
		},
	},
})

-- CSS (mason: css-lsp)
vim.lsp.config("cssls", {
	settings = {
		css  = { validate = true, lint = { unknownAtRules = "ignore" } },
		less = { validate = true },
		scss = { validate = true },
	},
})

-- HASKELL (mason: haskell-language-server)
vim.lsp.config("hls", {
	settings = {
		haskell = {
			formattingProvider = "ormolu",
			plugin = {
				inlayHints = { globalOn = true },
			},
		},
	},
})

-- RUST (mason: rust-analyzer)
vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			inlayHints = {
				bindingModeHints        = { enable = true },
				chainingHints           = { enable = true },
				closingBraceHints       = { enable = true, minLines = 10 },
				closureReturnTypeHints  = { enable = "always" },
				expressionAdjustmentHints = { enable = "always" },
				lifetimeElisionHints    = { enable = "always", useParameterNames = true },
				parameterHints          = { enable = true },
				rangeExclusiveHints     = { enable = true },
				typeHints               = {
					enable                       = true,
					hideClosureInitialization    = false,
					hideNamedConstructor         = false,
				},
			},
			checkOnSave = true,
		},
	},
})

-- JAVA (mason: jdtls)
vim.lsp.config("jdtls", {
	settings = {
		java = {
			inlayHints = {
				parameterNames = { enabled = "all" },
			},
			signatureHelp  = { enabled = true },
			contentProvider = { preferred = "fernflower" },
		},
	},
})

----------------------------------------------
-- Keymaps
----------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_config", { clear = true }),
	callback = function(args)
		local bufnr = args.buf

		vim.keymap.set("n", "<leader>h", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			vim.notify(vim.lsp.inlay_hint.is_enabled() and "Inlay hints enabled" or "Inlay hints disabled")
		end, { buffer = bufnr, desc = "Toggle inlay hints" })

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Goto definition" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Goto references" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
		-- vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostic" })
		vim.keymap.set("n", "<leader>cd", function()
			require("lsp_lines").toggle()
		end, { buffer = bufnr, desc = "Toggle diagnostics" })
	end,
})
