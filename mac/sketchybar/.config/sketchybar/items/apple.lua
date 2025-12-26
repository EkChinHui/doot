local colors = require("colors")

sbar.add("item", "apple", {
  icon = {
    string = "󰄛",
    font = {
      family = "FiraCode Nerd Font Mono",
      style = "Regular",
      size = 28.0,
    },
    color = colors.green,
    padding_left = 8,
    padding_right = 0,
  },
  label = { drawing = false },
  background = { drawing = false },
  padding_left = 2,
  padding_right = 0,
})
