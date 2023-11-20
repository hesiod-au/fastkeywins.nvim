# fastkeywins.nvim
A nvim lua plugin for keyboard driven window creation, navigation and resizing. 


![Demo Animation](demo.gif)

## Installation & Configuration

```lua
-- Packer w/ example configuration
use {"hesiod-au/fastkeywins.nvim",
    config = function()
        require("fastkeywins").setup(
        {
            -- defaults can be found in config.lua, 
            keychoice = "arrows", -- "arrows" or "hjkl"
            resize_amount = 1, -- default arrow resize amount
            after_split = "telescope", -- "telescope" will run telescope.builtin.find_files()
            terminal_local_keybind = "<leader>t", -- key combo string
            terminal_standard_keybind = "<leader>y", -- key combo string
            terminal_start_height = 20,
            toggle_minimize_keybind = "`",
            toggle_minimize_keybind_force_hz = "<C-`>"
        })
    end
}
```
Then, after the code is loaded (in an "after" config for instance):
```lua
-- ~/.config/nvim/lua/after/example.lua
require("fastkeywins").init_keys()
```

## Usage
The plugin sets up functions and key binds that do the following:

### Window navigation and new window creation:
* Alt-{arrows} or Alt-{h,j,k,l} will navigate between existing windows.
* If a window doesn't exist in the direction specified, one is created.
* If set (and present), telescope.find_files() can be loaded in the new window on creation.

### Window resizing:
* Ctrl-{arrows} or Ctrl-{h,j,k,l} will resize the current window 
* Resize is based on relative direction from current window
* "Minimize" toggle will resize window instantly between (tiny, 0.25, 0.5, 1.0 - tiny)
    - This toggle is window layout aware and is opinionated
    - It will resize to affect less windows rather than more
    - Where both options are equal it will resize vertically
    - Force hz (horizontal) (separate keybind) will force the resize horizontally

### Terminal spawning:
* Local terminal keybind will:
    - Spawn a terminal at the bottom of the current windows
    - Terminal will be in folder local to current window file
    - Switches to terminal, enters insert mode, ready to type
* Standard terminal keybind does the same but in the dir when nvim was started.
