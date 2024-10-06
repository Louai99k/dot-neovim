local configs = require("nvim-treesitter.configs")

configs.setup({
	ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "typescript", "css", "php" },
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})
