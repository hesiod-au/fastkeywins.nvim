local M = {}
function M.defaults()
    local defaults = {
        keychoice = "arrows", -- "arrows" or "hjkl"
        resize_amount = 1,
        after_split = "", -- "telescope" will run telescope.builtin.find_files()
        terminal_keybind = nil, -- key combo string
        toggle_minimize_keybind = nil -- key combo string
    }
    return defaults
end

M.options = {}

function M.setup(options)
    options = options or {}
    M.options = vim.tbl_deep_extend("force", {}, M.defaults(), options)
end

return M
