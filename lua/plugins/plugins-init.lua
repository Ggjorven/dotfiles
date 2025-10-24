local lazy = require("core.plugins-setup")

lazy.setup({
	-- Mason (Binary installer)
	{ 
	  "mason-org/mason.nvim",
	  config = true
	},

	-- Theme
	{ "folke/tokyonight.nvim" },
	--	{ "ellisonleao/gruvbox.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	
	-- Mode and file line at bottom
	{ "nvim-lualine/lualine.nvim" },

	-- Telescope
	{ "nvim-lua/plenary.nvim" },  -- Required by telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { 
			"nvim-lua/plenary.nvim" 
		}
	},
	
	-- UI
	{ "rcarriga/nvim-notify" },
	{ "MunifTanjim/nui.nvim" },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		}
	},

	-- Terminal
	{ "itmecho/neoterm.nvim" },

	-- LSP
	{ "hrsh7th/cmp-nvim-lsp" }, 
	{ "hrsh7th/cmp-buffer" }, 
	{ "hrsh7th/cmp-path" }, 
	{ "hrsh7th/lspkind-nvim" }, 
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind-nvim",
		},
		config = true
	},
    {
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" }
  	},

  	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-lspconfig.nvim" },
    }	
})
