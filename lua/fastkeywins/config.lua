local M = {}

function M.defaults()
	return {
		resize_amount = 1, -- default resize amount
		after_split = "", -- "telescope" will run telescope.builtin.find_files()
		active_win_number = true, -- active win settings are applied on selection
		active_win_relativenumber = true, -- you will want to set these originally as well
		active_win_signcolumn = "auto",
	}
end

M.options = {}

function M.setup(options)
	M.options = vim.tbl_deep_extend("force", {}, M.defaults(), options or {})
end

return M
