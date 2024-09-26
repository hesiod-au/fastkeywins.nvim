--print("hello world")
local Config = require("fastkeywins.config")

local M = {}

M.setup = function(options)
	Config.setup(options)
end

M.navigate_and_split = function(direction)
	-- Implementation of M.navigate_and_split
	local cur_win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_option(0, "number", false)
	vim.api.nvim_win_set_option(0, "relativenumber", false)
	vim.api.nvim_win_set_option(0, "signcolumn", "no")
	vim.cmd("wincmd " .. direction)

	if cur_win == vim.api.nvim_get_current_win() then
		if direction == "h" or direction == "l" then
			vim.cmd("vsplit")
		else
			vim.cmd("split")
		end
		vim.api.nvim_set_current_win(cur_win)
		vim.api.nvim_win_set_option(0, "number", Config.options.active_win_number)
		vim.api.nvim_win_set_option(0, "relativenumber", Config.options.active_win_relativenumber)
		vim.api.nvim_win_set_option(0, "signcolumn", Config.options.active_win_signcolumn)
		if Config.options.after_split == "telescope" then
			require("telescope.builtin").find_files()
		end
	else
		vim.api.nvim_win_set_option(0, "number", Config.options.active_win_number)
		vim.api.nvim_win_set_option(0, "relativenumber", Config.options.active_win_relativenumber)
		vim.api.nvim_win_set_option(0, "signcolumn", Config.options.active_win_signcolumn)
	end
end

function M.is_window_in_direction(direction)
	local cur_win = vim.api.nvim_get_current_win()
	vim.cmd("wincmd " .. direction)
	local changed_win = vim.api.nvim_get_current_win()

	-- Restore the previous window focus
	if cur_win ~= changed_win then
		vim.api.nvim_set_current_win(cur_win)
	end
	return cur_win ~= changed_win
end

function M.resize_window(direction)
	local resize_amount = Config.options.resize_amount
	local increase, decrease

	if direction == "Up" then
		increase, decrease = "resize +" .. tostring(resize_amount), "resize -" .. tostring(resize_amount)
	elseif direction == "Down" then
		increase, decrease = "resize +" .. tostring(resize_amount), "resize -" .. tostring(resize_amount)
	elseif direction == "Left" then
		increase, decrease =
			"vertical resize +" .. tostring(resize_amount), "vertical resize -" .. tostring(resize_amount)
	elseif direction == "Right" then
		increase, decrease =
			"vertical resize +" .. tostring(resize_amount), "vertical resize -" .. tostring(resize_amount)
	end

	if M.is_window_in_direction(({ Up = "k", Down = "j", Left = "h", Right = "l" })[direction]) then
		vim.cmd(increase)
	else
		vim.cmd(decrease)
	end
end

local return_window_axes = function()
	if
		(M.is_window_in_direction("j") or M.is_window_in_direction("k"))
		and (M.is_window_in_direction("h") or M.is_window_in_direction("l"))
	then
		return "both"
	elseif M.is_window_in_direction("j") or M.is_window_in_direction("k") then
		return "vertical"
	elseif M.is_window_in_direction("h") or M.is_window_in_direction("l") then
		return "horizontal"
	else
		return nil
	end
end

local resize_window = function(axis)
	if axis == "vertical" then
		local height = vim.api.nvim_win_get_height(0)
		local total_height = vim.api.nvim_get_option("lines")
		if height < 10 then
			M.new_height = total_height / 4
		elseif height < (total_height / 3) then
			M.new_height = total_height / 2
		elseif height < (total_height - 5) then
			M.new_height = (total_height - 5)
		else
			M.new_height = 4
		end
		vim.cmd("resize " .. M.new_height)
		return
	else
		local width = vim.api.nvim_win_get_width(0)
		local total_width = vim.api.nvim_get_option("columns")
		if width < 21 then
			M.new_width = total_width / 4
		elseif width < (total_width / 3) then
			M.new_width = total_width / 2
		elseif width < (total_width - 40) then
			M.new_width = (total_width - 20)
		else
			M.new_width = 20
		end
		vim.cmd("vertical resize " .. M.new_width)
		return
	end
end

M.toggle_minimize_window = function(force_hz)
	force_hz = force_hz or false
	local axes = return_window_axes()
	local cur_win = vim.api.nvim_get_current_win()
	if axes == "both" then
		if force_hz then
			resize_window("horizontal")
			return
		end
		if M.is_window_in_direction("j") then
			vim.cmd("wincmd j")
			if return_window_axes() == "both" then
				vim.api.nvim_set_current_win(cur_win)
				resize_window("vertical")
				return
			else
				vim.api.nvim_set_current_win(cur_win)
				resize_window("horizontal")
				return
			end
		end
		if M.is_window_in_direction("k") then
			vim.cmd("wincmd k")
			if return_window_axes() == "both" then
				vim.api.nvim_set_current_win(cur_win)
				resize_window("vertical")
				return
			else
				vim.api.nvim_set_current_win(cur_win)
				resize_window("horizontal")
				return
			end
		end
	else
		resize_window(axes)
		return
	end
end

M.open_terminal_in_current_buffer_dir = function(size)
	local bufnr = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	local bufdir = vim.fn.fnamemodify(bufname, ":h")
	vim.cmd("split")
	vim.cmd("wincmd j")
	vim.cmd("resize " .. size)
	vim.cmd("term")
	if bufdir ~= "" then
		vim.fn.chansend(vim.b.terminal_job_id, "cd " .. bufdir .. "\n")
	end
	vim.cmd("startinsert")
end

M.open_terminal_standard = function(size)
	vim.cmd("split")
	vim.cmd("wincmd j")
	vim.cmd("resize " .. size)
	vim.cmd("term")
	vim.cmd("startinsert")
end

return M
