vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader><CR>", "o<ESC>", { desc = "Insert new line" })

vim.keymap.set("i", "<C-v>", "<C-c>pa", { desc = "Make Ctrl+v paste" })
vim.keymap.set("v", "<leader>s", "<ESC>/\\%V", { desc = "Search in selected area" })
