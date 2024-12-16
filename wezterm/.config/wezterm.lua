-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrains Mono", { stretch = "Expanded" })
config.color_scheme = "DoomOne"
-- config.color_scheme = 'duckbones'

config.window_background_opacity = 1.0

config.animation_fps = 120
config.max_fps = 120
config.window_decorations = "RESIZE"
config.scrollback_lines = 5000

config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}
config.default_workspace = "home"
config.line_height = 1.1

config.keys = {
  { key = "Enter", mods = "ALT", action = act.DisableDefaultAssignment  },

  { key = "Enter", mods = "CMD", action = act.ToggleFullScreen },
}

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
