local colors = require("colors")
local settings = require("settings")

local aerospace_mode = sbar.add("item", "aerospace_mode", {
  position = "left",
  icon = {
    string = "􀍟",
    font = {
      family = settings.font,
      size = 16.0,
    },
    color = colors.bg0,
    padding_left = 8,
    padding_right = 4,
  },
  label = {
    string = "SERVICE",
    font = {
      family = settings.font,
      style = "Bold",
      size = 13.0,
    },
    color = colors.bg0,
    padding_right = 8,
  },
  background = {
    color = colors.orange,
    corner_radius = 6,
    height = 26,
  },
  drawing = false,
})

aerospace_mode:subscribe("aerospace_mode_change", function(env)
  local mode = env.MODE
  sbar.animate("quadratic", 15, function()
    if mode == "service" then
      aerospace_mode:set({ drawing = true })
    else
      aerospace_mode:set({ drawing = false })
    end
  end)
end)
