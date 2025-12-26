local colors = require("colors")
local settings = require("settings")

local cal = sbar.add("item", "calendar", {
  icon = {
    string = "󰃭",
    font = {
      family = settings.font,
      size = 16.0,
    },
    color = colors.aqua,
    padding_left = 6,
    padding_right = 4,
  },
  label = {
    font = {
      family = settings.font,
      style = "Semibold",
      size = 14.0,
    },
    color = colors.fg1,
    padding_left = 0,
    padding_right = 6,
  },
  background = {
    color = colors.bg1,
    corner_radius = 6,
    height = 26,
  },
  position = "right",
  update_freq = 30,
  padding_left = 2,
  padding_right = 4,
})

local function update()
  local datetime = os.date("%a %d %b  %H:%M")
  cal:set({ label = datetime })
end

cal:subscribe("routine", update)
cal:subscribe("forced", update)

update()

