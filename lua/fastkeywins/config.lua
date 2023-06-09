local M = {}
function M.defaults()
    local defaults = {
        keychoice = "arrows", -- "arrows" or "hjkl"
        resize_amount = 1, -- default arrow resize amount
        after_split = "", -- "telescope" will run telescope.builtin.find_files()
        terminal_local_keybind = nil, -- key combo string
        terminal_standard_keybind = nil, -- key combo string
        terminal_start_height = 10,
        toggle_minimize_keybind = nil, -- key combo string
        toggle_minimize_keybind_force_hz = nil, -- key combo string
        active_win_number = true, -- active win settings are applied on selection
        active_win_relativenumber = true, -- you will want to set these originally as well
        active_win_signcolumn = 'auto'
    }
    return defaults
end

M.options = {}

function M.setup(options)
    options = options or {}
    M.options = vim.tbl_deep_extend("force", {}, M.defaults(), options)
end

return M
