local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  height = 36,
  color = colors.bar.bg,
  border_color = colors.bar.border,
  border_width = 0,
  shadow = false,
  sticky = true,
  padding_right = 8,
  padding_left = 8,
  blur_radius = 30,
  topmost = "window",
  y_offset = 10,
  margin = 18,
  corner_radius = 10,
})
