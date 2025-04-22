local conform = require("conform")
local lspconfig = require("lspconfig")
local lua_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Set Up
require("mason").setup()
require("mason-lspconfig").setup({})
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
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
	capabilities = lua_capabilities,
})

--Enable (broadcasting) snippet capability for completion
local html_capabilities = vim.lsp.protocol.make_client_capabilities()
html_capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.html.setup({
	capabilities = html_capabilities,
	filetypes = { "blade", "html" },
})

--Enable (broadcasting) snippet capability for completion
local css_capabilities = vim.lsp.protocol.make_client_capabilities()
css_capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.cssls.setup({
	capabilities = css_capabilities,
})

lspconfig.clangd.setup({})
lspconfig.intelephense.setup({})
lspconfig.tailwindcss.setup({})

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
			require("conform").format({ bufnr = args.buf })
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
	end,
})
