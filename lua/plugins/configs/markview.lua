require("markview").setup({
	preview = {
		icons = "devicons",
		enable = false,
	},
})

vim.api.nvim_set_keymap("n", "<leader>m", "<CMD>Markview<CR>", { desc = "Toggles `markview` previews globally." })
