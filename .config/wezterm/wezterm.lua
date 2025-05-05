local wezterm = require "wezterm"
local theme = require "colors-wezterm"

local config = {
	font = wezterm.font("Fira Code Nerd Font"),
	font_size = 12.0,

	window_padding = {
		left = 25,
		right = 25,
		top = 29,
		bottom = 35,
	},


	cursor_thickness = 10,
	cursor_blink_rate = 0,
	default_cursor_style = "SteadyBlock",

	underline_thickness = 2.0,
	underline_position = -2.0,
	strikethrough_position = 4.0,

	default_prog = { "/bin/zsh" },

	enable_tab_bar = false,

	colors = theme.colors
}

return config
