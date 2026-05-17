local conform = require("conform")

-- Set Up
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {},
	automatic_enable = false,
})
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		javascriptreact = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		json = { "prettier" },
		cpp = { "clang-format" },
		php = { "php" },
		blade = { "blade-formatter" },
		python = { "black" },
	},
	formatters = {
		php = {
			command = "php-cs-fixer",
			args = {
				"fix",
				"$FILENAME",
			},
			stdin = false,
		},
	},
})

vim.env.PHP_CS_FIXER_IGNORE_ENV = "true"

-- LSP Servers Setup

-- Lua
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- Python
vim.lsp.config("pylsp", {})

-- HTML
--Enable (broadcasting) snippet capability for completion
local html_capabilities = vim.lsp.protocol.make_client_capabilities()
html_capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config("html", {
	capabilities = html_capabilities,
	filetypes = { "blade", "html" },
})

-- CSS
--Enable (broadcasting) snippet capability for completion
local css_capabilities = vim.lsp.protocol.make_client_capabilities()
css_capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config("cssls", {
	capabilities = css_capabilities,
})

-- Cpp
vim.lsp.config("clangd", {})

-- Tailwindcss
vim.lsp.config("tailwindcss", {})

-- PHP
vim.lsp.config("intelephense", {})

-- Visual Studio TS Language Server
vim.lsp.config("vtsls", {})

-- Rust
vim.lsp.config("rust_analyzer", {})

-- #################### Enable LSP ####################
vim.lsp.enable({ "lua_ls", "pylsp", "html", "cssls", "clangd", "tailwindcss", "intelephense", "vtsls", "rust_analyzer" })
-- #################### Enable LSP ####################

-- New File Types

vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})

-- Key Bindings
vim.keymap.set({ "v", "n" }, "<leader>lf", conform.format, { desc = "Format File" })

-- Events
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		local filename = vim.fn.expand("%:p")

		if not filename:match("node_modules") then
			conform.format({ bufnr = args.buf })
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
	end,
})
