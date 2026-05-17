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
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
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
		"m4xshen/autoclose.nvim",
		init = function()
			require("autoclose").setup()
		end,
	},
  {
    'saghen/blink.cmp',
    dependencies = {
      'saghen/blink.lib',
      -- optional: provides snippets for the snippet source
      'rafamadriz/friendly-snippets',
    },
    build = function()
      -- build the fuzzy matcher, wait up to 60 seconds
      -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
      require('blink.cmp').build():wait(60000)
    end,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      completion = { documentation = { auto_show = false } },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
      fuzzy = { implementation = "lua" }
    },
  }
}

require("lazy").setup(plugins)
