local M = {}

M.save_and_clear_qf = function()
	local filename = vim.fn.input("Save QF to .tmp/", "", "file")

	if filename == "" then
		return
	end

	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	local save_path = vim.fn.getcwd() .. "/.tmp/" .. filename
	vim.fn.mkdir(vim.fn.getcwd() .. "/.tmp", "p")

	vim.fn.writefile(lines, save_path)

	vim.fn.setqflist({})

	print("Save to .tmp/" .. filename .. " and cleared quickfix")
end

return M
