local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
  updates = "when_shown",
  icon = {
    font = {
      family = settings.font,
      style = "Bold",
      size = 15.0
    },
    color = colors.fg1,
    padding_left = 6,
    padding_right = 4,
  },
  label = {
    font = {
      family = settings.font,
      style = "Medium",
      size = 14.0
    },
    color = colors.fg2,
    padding_left = 4,
    padding_right = 6,
  },
  background = {
    height = 26,
    corner_radius = 8,
    border_width = 0,
    color = colors.bg1,
  },
  popup = {
    background = {
      border_width = 1,
      corner_radius = 8,
      border_color = colors.bg3,
      color = colors.bg0,
      shadow = { drawing = true },
    },
    blur_radius = 30,
  },
  padding_left = 2,
  padding_right = 2,
})

