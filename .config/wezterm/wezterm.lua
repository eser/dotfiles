-- Pull in the wezterm API
local wezterm = require("wezterm")

-- get configuration
local config = wezterm.config_builder()

-- plugins
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- tabbar (configure plugins first)
tabline.setup({
	options = {
		icons_enabled = true,
		tabs_enabled = true,
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = "",
		theme_overrides = {
			normal_mode = {
				y = { bg = "black" },
			},
		},
	},
	sections = {
		tabline_a = {},
		tabline_b = {},
		tabline_c = {},
		tab_active = {
			{ "process", padding = 2 },
		},
		tab_inactive = {
			{ "process", padding = 2 },
		},
		tabline_x = {},
		tabline_y = { { "battery", icons_only = true, padding = 1 } },
		tabline_z = { " eser.dev " },
	},
})

tabline.apply_to_config(config)

-- fonts
config.font = wezterm.font({
	family = "MonoLisaEser Nerd Font",
})
config.font_size = 14
config.line_height = 1.12
config.freetype_load_target = "Normal"

-- window
config.initial_cols = 120
config.initial_rows = 28
config.window_decorations = "RESIZE|INTEGRATED_BUTTONS"
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20
config.window_padding = {
	left = 25,
	right = 25,
	top = 0,
	bottom = 0,
}

-- sounds
config.audible_bell = "Disabled"

-- cursor
config.default_cursor_style = "BlinkingUnderline"
config.cursor_thickness = "0.075cell"
config.cursor_blink_ease_in = "EaseOut"
config.cursor_blink_ease_out = "Linear"
config.cursor_blink_rate = 1200
-- config.force_reverse_video_cursor = false

-- themes
local theme_selected = wezterm.color.get_builtin_schemes()["Ocean Dark (Gogh)"]

theme_selected.background = "black"

config.color_schemes = {
	["Ocean Dark (Eser)"] = theme_selected,
}
config.color_scheme = "Ocean Dark (Eser)"

-- keyword bindings
local act = wezterm.action

config.keys = {
	{ mods = "SHIFT", key = "Enter", action = act({ SendString = "\x1b\r" }) },
	{ mods = "OPT", key = "LeftArrow", action = act.SendKey({ mods = "ALT", key = "b" }) },
	{ mods = "OPT", key = "RightArrow", action = act.SendKey({ mods = "ALT", key = "f" }) },
	{ mods = "OPT", key = "Backspace", action = act.SendKey({ mods = "CTRL", key = "w" }) },
	{ mods = "CMD", key = "LeftArrow", action = act.SendKey({ mods = "CTRL", key = "a" }) },
	{ mods = "CMD", key = "RightArrow", action = act.SendKey({ mods = "CTRL", key = "e" }) },
	{ mods = "CMD", key = "Backspace", action = act.SendKey({ mods = "CTRL", key = "u" }) },
	-- { mods = "CMD|OPT", key = "LeftArrow", action = act.ActivateTabRelative(-1) },
	-- { mods = "CMD|OPT", key = "RightArrow", action = act.ActivateTabRelative(1) },
	-- { mods = "CMD|SHIFT", key = "LeftArrow", action = act.ActivateTabRelative(-1) },
	-- { mods = "CMD|SHIFT", key = "RightArrow", action = act.ActivateTabRelative(1) },
	{ mods = "CMD", key = "w", action = act.CloseCurrentPane({ confirm = false }) },
	{ mods = "CMD|SHIFT", key = "d", action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }) },
	{ mods = "CMD", key = "d", action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }) },
}

-- final configuration
return config
