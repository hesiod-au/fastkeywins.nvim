--print("hello world")
local Config = require("fastkeywins.config")

local M = {}

M.setup = function(options)
    Config.setup(options)
end

M.init_keys = function()
    if Config.options.keychoice == "arrows" then
        _G.fkw_keymaps = {
            split = {
                {'n', '<A-Up>', '<Cmd>lua _G.fkw_navigate_and_split("k")<CR>', {noremap = true, silent = true}},
                {'n', '<A-Down>', '<Cmd>lua _G.fkw_navigate_and_split("j")<CR>', {noremap = true, silent = true}},
                {'n', '<A-Left>', '<Cmd>lua _G.fkw_navigate_and_split("h")<CR>', {noremap = true, silent = true}},
                {'n', '<A-Right>', '<Cmd>lua _G.fkw_navigate_and_split("l")<CR>', {noremap = true, silent = true}},
                {'t', '<A-Up>', '<C-\\><C-n><Cmd>lua _G.fkw_navigate_and_split("k")<CR>', {noremap = true, silent = true}},
                {'t', '<A-Down>', '<C-\\><C-n><Cmd>lua _G.fkw_navigate_and_split("j")<CR>', {noremap = true, silent = true}},
                {'t', '<A-Left>', '<C-\\><C-n><Cmd>lua _G.fkw_navigate_and_split("h")<CR>', {noremap = true, silent = true}},
                {'t', '<A-Right>', '<C-\\><C-n><Cmd>lua _G.fkw_navigate_and_split("l")<CR>', {noremap = true, silent = true}},
            },
            resize = {
                {'n', '<C-Up>', '<Cmd>lua _G.fkw_resize_window("Up")<CR>', {noremap = true, silent = true}},
                {'n', '<C-Down>', '<Cmd>lua _G.fkw_resize_window("Down")<CR>', {noremap = true, silent = true}},
                {'n', '<C-Left>', '<Cmd>lua _G.fkw_resize_window("Left")<CR>', {noremap = true, silent = true}},
                {'n', '<C-Right>', '<Cmd>lua _G.fkw_resize_window("Right")<CR>', {noremap = true, silent = true}},
                {'t', '<C-Up>', '<C-\\><C-n><Cmd>lua _G.fkw_resize_window("Up")<CR>:startinsert<CR>', {noremap = true, silent = true}},
                {'t', '<C-Down>', '<C-\\><C-n><Cmd>lua _G.fkw_resize_window("Down")<CR>:startinsert<CR>', {noremap = true, silent = true}},
                {'t', '<Home>', '<C-\\><C-n><Cmd>lua _G.fkw_resize_window("Left")<CR>:startinsert<CR>', {noremap = true, silent = true}},
                {'t', '<End>', '<C-\\><C-n><Cmd>lua _G.fkw_resize_window("Right")<CR>:startinsert<CR>', {noremap = true, silent = true}},
            }
        }
    elseif Config.options.keychoice == "hjkl" then
        _G.fkw_keymaps = {
            split = {
                {'n', '<A-k>', '<Cmd>lua _G.fkw_navigate_and_split("k")<CR>', {noremap = true, silent = true}},
                {'n', '<A-j>', '<Cmd>lua _G.fkw_navigate_and_split("j")<CR>', {noremap = true, silent = true}},
                {'n', '<A-h>', '<Cmd>lua _G.fkw_navigate_and_split("h")<CR>', {noremap = true, silent = true}},
                {'n', '<A-l>', '<Cmd>lua _G.fkw_navigate_and_split("l")<CR>', {noremap = true, silent = true}},
                {'t', '<A-k>', '<C-\\><C-n><Cmd>lua _G.fkw_navigate_and_split("k")<CR>', {noremap = true, silent = true}},
                {'t', '<A-j>', '<C-\\><C-n><Cmd>lua _G.fkw_navigate_and_split("j")<CR>', {noremap = true, silent = true}},
                {'t', '<A-h>', '<C-\\><C-n><Cmd>lua _G.fkw_navigate_and_split("h")<CR>', {noremap = true, silent = true}},
                {'t', '<A-l>', '<C-\\><C-n><Cmd>lua _G.fkw_navigate_and_split("l")<CR>', {noremap = true, silent = true}},
            },
            resize = {
                {'n', '<C-k>', '<Cmd>lua _G.fkw_resize_window("Up")<CR>', {noremap = true, silent = true}},
                {'n', '<C-j>', '<Cmd>lua _G.fkw_resize_window("Down")<CR>', {noremap = true, silent = true}},
                {'n', '<C-h>', '<Cmd>lua _G.fkw_resize_window("Left")<CR>', {noremap = true, silent = true}},
                {'n', '<C-l>', '<Cmd>lua _G.fkw_resize_window("Right")<CR>', {noremap = true, silent = true}},
                {'t', '<C-k>', '<C-\\><C-n><Cmd>lua _G.fkw_resize_window("Up")<CR>:startinsert<CR>', {noremap = true, silent = true}},
                {'t', '<C-j>', '<C-\\><C-n><Cmd>lua _G.fkw_resize_window("Down")<CR>:startinsert<CR>', {noremap = true, silent = true}},
                {'t', '<C-h>', '<C-\\><C-n><Cmd>lua _G.fkw_resize_window("Left")<CR>:startinsert<CR>', {noremap = true, silent = true}},
                {'t', '<C-l>', '<C-\\><C-n><Cmd>lua _G.fkw_resize_window("Right")<CR>:startinsert<CR>', {noremap = true, silent = true}},
            }
        }
    end
    for _, keymap in ipairs(_G.fkw_keymaps.split) do
        vim.api.nvim_set_keymap(unpack(keymap))
    end

    for _, keymap in ipairs(_G.fkw_keymaps.resize) do
        vim.api.nvim_set_keymap(unpack(keymap))
    end

    if Config.options.terminal_local_keybind then
        vim.api.nvim_set_keymap("n", Config.options.terminal_local_keybind, "<Cmd>lua require('fastkeywins').open_terminal_in_current_buffer_dir(" .. Config.options.terminal_start_height .. ")<CR>", {silent = true})
    end

    if Config.options.terminal_standard_keybind then
        vim.api.nvim_set_keymap("n", Config.options.terminal_standard_keybind, "<Cmd>lua require('fastkeywins').open_terminal_standard(".. Config.options.terminal_start_height .. ")<CR>", {silent = true})
    end

    if Config.options.toggle_minimize_keybind then
        vim.api.nvim_set_keymap("n", Config.options.toggle_minimize_keybind, "<Cmd>lua require('fastkeywins').toggle_minimize_window()<CR>", {silent = true})
    end

    if Config.options.toggle_minimize_keybind_force_hz then
        vim.api.nvim_set_keymap("n", Config.options.toggle_minimize_keybind_force_hz, "<Cmd>lua require('fastkeywins').toggle_minimize_window(true)<CR>", {silent = true})
    end
end


function _G.fkw_is_window_in_direction(direction)
  local cur_win = vim.api.nvim_get_current_win()
  vim.cmd('wincmd ' .. direction)
  local changed_win = vim.api.nvim_get_current_win()

  -- Restore the previous window focus
  if cur_win ~= changed_win then
      vim.api.nvim_set_current_win(cur_win)
  end
  return cur_win ~= changed_win
end

function _G.fkw_resize_window(direction)
  local resize_amount = Config.options.resize_amount
  local increase, decrease

  if direction == 'Up' then
    increase, decrease = 'resize +' .. tostring(resize_amount), 'resize -' .. tostring(resize_amount)
  elseif direction == 'Down' then
    increase, decrease = 'resize +' .. tostring(resize_amount), 'resize -' .. tostring(resize_amount)
  elseif direction == 'Left' then
    increase, decrease = 'vertical resize +' .. tostring(resize_amount), 'vertical resize -' .. tostring(resize_amount)
  elseif direction == 'Right' then
    increase, decrease = 'vertical resize +' .. tostring(resize_amount), 'vertical resize -' .. tostring(resize_amount)
  end

  if _G.fkw_is_window_in_direction(({Up = 'k', Down = 'j', Left = 'h', Right = 'l'})[direction]) then
    vim.cmd(increase)
  else
    vim.cmd(decrease)
  end
end

_G.fkw_navigate_and_split = function(direction)
  local cur_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_option(0, 'number', false)
  vim.api.nvim_win_set_option(0, 'relativenumber', false)
  vim.api.nvim_win_set_option(0, 'signcolumn', 'no')
  -- Try navigating to the desired window
  vim.cmd('wincmd ' .. direction)

  -- If the window did not change, it means there was no window in the desired direction
  if cur_win == vim.api.nvim_get_current_win() then
    if direction == 'h' then
      vim.cmd('vsplit')
      vim.api.nvim_set_current_win(cur_win)
    elseif direction == 'l' then
      vim.cmd('vsplit')
      vim.api.nvim_set_current_win(cur_win)
    elseif direction == 'j' then
      vim.cmd('split')
      vim.api.nvim_set_current_win(cur_win)
    elseif direction == 'k' then
      vim.cmd('split')
      vim.api.nvim_set_current_win(cur_win)
    end
    vim.api.nvim_win_set_option(0, 'number', Config.options.active_win_number)
    vim.api.nvim_win_set_option(0, 'relativenumber', Config.options.active_win_relativenumber)
    vim.api.nvim_win_set_option(0, 'signcolumn', Config.options.active_win_signcolumn)
    if Config.options.after_split == "telescope" then
        local builtin = require('telescope.builtin')
        builtin.find_files()
    end
  else
    vim.api.nvim_win_set_option(0, 'number', Config.options.active_win_number)
    vim.api.nvim_win_set_option(0, 'relativenumber', Config.options.active_win_relativenumber)
    vim.api.nvim_win_set_option(0, 'signcolumn', Config.options.active_win_signcolumn)
  end
end

local return_window_axes = function()
    if ( _G.fkw_is_window_in_direction('j') or _G.fkw_is_window_in_direction('k') ) and
        ( _G.fkw_is_window_in_direction('h') or _G.fkw_is_window_in_direction('l') ) then
        return "both"
    elseif ( _G.fkw_is_window_in_direction('j') or _G.fkw_is_window_in_direction('k') ) then
        return "vertical"
    elseif ( _G.fkw_is_window_in_direction('h') or _G.fkw_is_window_in_direction('l') ) then
        return "horizontal"
    else
        return nil
    end
end

local resize_window = function(axis)
    if axis == "vertical" then
        local height = vim.api.nvim_win_get_height(0)
        local total_height = vim.api.nvim_get_option('lines')
        if height < 10 then
            _G.fkw_new_height = total_height / 4
        elseif height < (total_height / 3) then
            _G.fkw_new_height = total_height / 2
        elseif height < (total_height - 5) then
            _G.fkw_new_height = (total_height - 5)
        else
            _G.fkw_new_height = 4
        end
        vim.cmd('resize ' .. _G.fkw_new_height)
        return
    else
        local width = vim.api.nvim_win_get_width(0)
        local total_width = vim.api.nvim_get_option('columns')
        if width < 21 then
            _G.fkw_new_width = total_width / 4
        elseif width < (total_width / 3) then
            _G.fkw_new_width = total_width / 2
        elseif width < (total_width - 40) then
            _G.fkw_new_width = (total_width - 20)
        else
            _G.fkw_new_width = 20
        end
        vim.cmd('vertical resize ' .. _G.fkw_new_width)
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
        if _G.fkw_is_window_in_direction('j') then
            vim.cmd('wincmd j')
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
        if _G.fkw_is_window_in_direction('k') then
            vim.cmd('wincmd k')
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
    local bufdir = vim.fn.fnamemodify(bufname, ':h')
    vim.cmd('split')
    vim.cmd('wincmd j')
    vim.cmd('resize ' .. size)
    vim.cmd('term')
    if bufdir ~= "" then
        vim.fn.chansend(vim.b.terminal_job_id, "cd " .. bufdir .. "\n")
    end
    vim.cmd('startinsert')
end

M.open_terminal_standard = function(size)
    vim.cmd('split')
    vim.cmd('wincmd j')
    vim.cmd('resize ' .. size)
    vim.cmd('term')
    vim.cmd('startinsert')
end


return M
