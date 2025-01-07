local telescope = require("telescope")
local builtin = require("telescope.builtin")
local nvim_tree_lib = require("nvim-tree.lib")

telescope.load_extension("live_grep_args")

-- Functions
local find_files = function()
	return builtin.find_files({ hidden = true })
end

local grep_at_current_tree_node = function()
	local node = nvim_tree_lib.get_node_at_cursor()
	if not node then
		return
	end
	telescope.extensions.live_grep_args.live_grep_args({ search_dirs = { node.absolute_path } })
end

local open_diagnostics = function()
	builtin.diagnostics({ bufnr = 0 })
end

-- Key Maps
vim.keymap.set("n", "<leader>ff", find_files, { desc = "Find files" })
vim.keymap.set(
	"n",
	"<leader>fs",
	telescope.extensions.live_grep_args.live_grep_args,
	{ noremap = true, desc = "Find in files" }
)
vim.keymap.set(
	"n",
	"<leader>fg",
	grep_at_current_tree_node,
	{ desc = "Find on tree cursor", silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>fq", builtin.resume, { desc = "Resume previous telescope" })
vim.keymap.set("n", "<leader>fe", builtin.grep_string, { desc = "Search for the word under cursor" })

-- LSP Key Bindings
vim.keymap.set("n", "<leader>lg", builtin.lsp_definitions, { desc = "Go To Definition" })
vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "Show References", silent = true, noremap = true })
vim.keymap.set("n", "<leader>ld", open_diagnostics, { desc = "Open diagnostics", silent = true, noremap = true })
vim.keymap.set(
	"n",
	"<leader>ls",
	builtin.lsp_document_symbols,
	{ desc = "Open document symbols", silent = true, noremap = true }
)
