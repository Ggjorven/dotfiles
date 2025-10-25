local lazy = require("core.lazy")

lazy.setup({
	-- Mason (Binary installer)
	{ 
		"mason-org/mason.nvim",
	  	config = function()
			require("plugins.mason").mason()
			require("plugins.mason").finish()
		end
	},

	-- Theme
	{ 
        "folke/tokyonight.nvim",
        config = function()
            require("plugins.colourscheme").tokyonight()
			require("plugins.colourscheme").finish()
        end
     },
	{ "kyazdani42/nvim-web-devicons" },
	
	-- Mode and file line at bottom
	{ 
        "nvim-lualine/lualine.nvim",
        config = function()
			require("plugins.lualine").lualine()
			require("plugins.lualine").finish()
		end
    },

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
			require("plugins.telescope").telescope()
			require("plugins.telescope").finish()
		end
	},
	
	-- UI (Notification & Commands)
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
        config = function()
			require("plugins.noice").noice()
			require("plugins.noice").notify()
			require("plugins.noice").finish()
		end
	},

	-- LSP
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "onsails/lspkind-nvim" },
		config = function()
			require("plugins.lsp").cmp()
		end
	},
    {
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
        config = function()
			require("plugins.lsp").mason_lspconfig()
		end
  	},
  	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-lspconfig.nvim" },
        config = function()
			require("plugins.lsp").finish()
		end
	}
})
