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

-- Key Maps
vim.keymap.set("n", "<leader>ff", find_files, { desc = "Find Files" })
vim.keymap.set(
	"n",
	"<leader>fs",
	telescope.extensions.live_grep_args.live_grep_args,
	{ noremap = true, desc = "Find In Files" }
)
vim.keymap.set(
	"n",
	"<leader>fg",
	grep_at_current_tree_node,
	{ desc = "Find On Tree Cursor", silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>fq", builtin.resume, { desc = "Resume Previous Telescope" })
vim.keymap.set("n", "<leader>fe", builtin.grep_string, { desc = "Resume Previous Telescope" })
