# fastkeywins.nvim

A Neovim Lua plugin for keyboard-driven window creation, navigation, and resizing.

![Demo Animation](demo.gif)

## Installation & Configuration

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "hesiod-au/fastkeywins.nvim",
  config = function()
    require("fastkeywins").setup({
      -- Optional: override default settings
      keychoice = "arrows", -- "arrows" or "hjkl"
      resize_amount = 1, -- default arrow resize amount
      after_split = "telescope", -- "telescope" will run telescope.builtin.find_files()
      terminal_local_keybind = "<leader>t", -- key combo string
      terminal_standard_keybind = "<leader>y", -- key combo string
      terminal_start_height = 20,
      toggle_minimize_keybind = "`",
      toggle_minimize_keybind_force_hz = "<C-`>"
    })
  end,
		keys = {
			-- Navigation and splitting (CTRL-SHIFT-ALT)
			{
				"<M-Left>",
				function()
					require("fastkeywins").navigate_and_split("h")
				end,
				desc = "Navigate or split left",
			},
			{
				"<M-Down>",
				function()
					require("fastkeywins").navigate_and_split("j")
				end,
				desc = "Navigate or split down",
			},
			{
				"<M-Up>",
				function()
					require("fastkeywins").navigate_and_split("k")
				end,
				desc = "Navigate or split up",
			},
			{
				"<M-Right>",
				function()
					require("fastkeywins").navigate_and_split("l")
				end,
				desc = "Navigate or split right",
			},

			-- Resizing (CTRL)
			{
				"<C-Left>",
				function()
					require("fastkeywins").resize_window("Left")
				end,
				desc = "Resize window left",
			},
			{
				"<C-Down>",
				function()
					require("fastkeywins").resize_window("Down")
				end,
				desc = "Resize window down",
			},
			{
				"<C-Up>",
				function()
					require("fastkeywins").resize_window("Up")
				end,
				desc = "Resize window up",
			},
			{
				"<C-Right>",
				function()
					require("fastkeywins").resize_window("Right")
				end,
				desc = "Resize window right",
			},

			-- Terminal operations
			{
				"<leader>t",
				function()
					require("fastkeywins").open_terminal_in_current_buffer_dir(20)
				end,
				desc = "Open terminal in current buffer dir",
			},
			{
				"<leader>y",
				function()
					require("fastkeywins").open_terminal_standard(20)
				end,
				desc = "Open standard terminal",
			},

			-- Window minimizing
			{
				"`",
				function()
					require("fastkeywins").toggle_minimize_window()
				end,
				desc = "Toggle minimize window",
			},
			{
				"<C-`>",
				function()
					require("fastkeywins").toggle_minimize_window(true)
				end,
				desc = "Toggle minimize window (force horizontal)",
			},
		},
  },
}
```

## Usage

The plugin sets up functions and key binds that do the following:

### Window navigation and new window creation:

- Alt-{arrows} or Alt-{h,j,k,l} will navigate between existing windows.
- If a window doesn't exist in the direction specified, one is created.
- If set (and present), telescope.find_files() can be loaded in the new window on creation.

### Window resizing:

- Ctrl-{arrows} or Ctrl-{h,j,k,l} will resize the current window
- Resize is based on relative direction from current window
- "Minimize" toggle will resize window instantly between (tiny, 0.25, 0.5, 1.0 - tiny)
  - This toggle is window layout aware and is opinionated
  - It will resize to affect fewer windows rather than more
  - Where both options are equal it will resize vertically
  - Force hz (horizontal) (separate keybind) will force the resize horizontally

### Terminal spawning:

- Local terminal keybind will:
  - Spawn a terminal at the bottom of the current windows
  - Terminal will be in folder local to current window file
  - Switches to terminal, enters insert mode, ready to type
- Standard terminal keybind does the same but in the dir when nvim was started.

## Customization

You can customize the keybindings and behavior by modifying the setup options and key mappings in your configuration.

```

```
