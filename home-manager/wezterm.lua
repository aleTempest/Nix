local wezterm = require("wezterm")
local config = wezterm.config_builder()
local opacity = 1

config.window_background_opacity = opacity

-- lmao
-- config.window_background_gradient = {
-- 	orientation = "Horizontal",
-- 	colors = {
-- 		"#00141a",
-- 		"#002b36",
-- 	},
-- }

config.font = wezterm.font("Iosevka Nerd Font")
config.color_scheme = "One Dark (Gogh)"
-- config.color_scheme = 'Oxocarbon Dark (Gogh)'
config.enable_tab_bar = false

return config
