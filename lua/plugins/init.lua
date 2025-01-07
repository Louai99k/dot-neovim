local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{
		"catppuccin/nvim",
		priority = 1000,
		config = function()
			vim.o.background = "dark"
			vim.cmd([[colorscheme catppuccin-mocha]])
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
			"stevearc/conform.nvim",
		},
		init = function()
			require("plugins.configs.lsp")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"rafamadriz/friendly-snippets",
		},
		init = function()
			require("plugins.configs.cmp")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		init = function()
			require("plugins.configs.treesitter")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		init = function()
			require("lualine").setup()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		init = function()
			require("plugins.configs.nvim-tree")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		init = function()
			require("plugins.configs.bufferline")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			"BurntSushi/ripgrep",
		},
		init = function()
			require("plugins.configs.telescope")
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		init = function()
			require("plugins.configs.tstools")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		init = function()
			require("gitsigns").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.configs.comment")
		end,
		lazy = false,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"m4xshen/autoclose.nvim",
		init = function()
			require("autoclose").setup()
		end,
	},
}

require("lazy").setup(plugins)
