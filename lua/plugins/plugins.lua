local lazy = require("core.lazy")

lazy.setup({
	-- Mason (Binary installer)
	{ 
		"mason-org/mason.nvim",
	  	config = function()
			require("plugins.mason").mason()
		end
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("plugins.mason").tools()
			require("plugins.mason").finish()
		end
	},

	-- Theme
	{ 
        "shaunsingh/nord.nvim",
        config = function()
            require("plugins.colourscheme").nord()
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
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make"
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
        config = function()
			require("plugins.telescope").telescope()
			require("plugins.telescope").fzf()
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
	},

    -- Multiple cursors (VimScript)
    {
        "smoka7/multicursors.nvim",
        event = "VeryLazy",
    },

    -- Auto close brackets
    {
        "m4xshen/autoclose.nvim",
        event = "InsertEnter",
        config = function()
            require("plugins.autoclose").autoclose()
            require("plugins.autoclose").finish()
        end
    },

	-- Debugger
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			require("plugins.dap").dap_virtual_text()
			require("plugins.dap").mason_dap()
			require("plugins.dap").dapui()
			require("plugins.dap").finish()
		end
	},

	-- Lazygit
	{
		"kdheepak/lazygit.nvim",
		event = "VeryLazy",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},

		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		keys = {
			{ "<leader>'", "<cmd>LazyGit<cr>", desc = "LazyGit" }
		}
	}
})
