-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrains Mono", { stretch = "Expanded" })

config.colors = require("cyberdream")

config.colors.tab_bar = {
  background = "rgba(0,0,0,0)",
}

config.window_background_opacity = 0.95
config.animation_fps = 120
config.max_fps = 120
config.window_decorations = "RESIZE"
config.scrollback_lines = 5000
config.window_close_confirmation = "NeverPrompt"
config.font_size = 14

config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

config.default_workspace = "home"
config.line_height = 1.2

config.keys = {
  { key = "Enter", mods = "ALT", action = act.DisableDefaultAssignment },

  { key = "Enter", mods = "CMD", action = act.ToggleFullScreen },
}

config.mouse_bindings = {
	-- CMD-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "SUPER",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.macos_window_background_blur = 50

-- config.window_frame = {
--         inactive_titlebar_bg = "none",
--         active_titlebar_bg = "none",
-- }

-- config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
-- config.keys = {
--   -- Send C-a when pressing C-a twice
--   { key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
--   { key = "c", mods = "LEADER", action = act.ActivateCopyMode },
--   { key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },
--
--   -- Pane keybindings
--   { key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
--   { key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
--   { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
--   { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
--   { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
--   { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
--   { key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
--   { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
--   { key = "o", mods = "LEADER", action = act.RotatePanes("Clockwise") },
--
--   { key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
--   { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
--   { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
--   { key = "n", mods = "LEADER", action = act.ShowTabNavigator },
-- }

return config
