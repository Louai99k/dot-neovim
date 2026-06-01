local configs = require("nvim-treesitter.config")

configs.setup({
	ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "typescript", "css", "php", "html", "python" },
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})
