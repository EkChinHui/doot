local colors = require("colors")
local settings = require("settings")
local app_icons = require("helper.app_icons")

-- Separator
local separator = sbar.add("item", "front_app.separator", {
  position = "left",
  icon = {
    string = "|",
    font = {
      family = settings.font,
      style = "Light",
      size = 16.0,
    },
    color = colors.bg3,
    padding_left = 8,
    padding_right = 8,
  },
  label = { drawing = false },
  background = { drawing = false },
})

local front_app = sbar.add("item", "front_app", {
  position = "left",
  icon = {
    font = "sketchybar-app-font:Regular:16.0",
    color = colors.fg1,
    padding_left = 6,
    padding_right = 4,
  },
  label = {
    font = {
      family = settings.font,
      style = "Semibold",
      size = 14.0,
    },
    color = colors.fg2,
    padding_left = 0,
    padding_right = 8,
  },
  background = {
    color = colors.bg1,
    corner_radius = 6,
    height = 26,
  },
  padding_left = 4,
})

local function update_front_app(app)
  local lookup = app_icons[app]
  local icon = lookup or app_icons["Default"]
  sbar.animate("quadratic", 15, function()
    front_app:set({
      icon = { string = icon },
      label = { string = app },
    })
  end)
end

front_app:subscribe("front_app_switched", function(env)
  update_front_app(env.INFO)
end)

-- Refresh front app on display change (e.g., monitor plug/unplug)
front_app:subscribe("display_change", function()
  sbar.exec("osascript -e 'tell application \"System Events\" to get name of first process whose frontmost is true' 2>/dev/null", function(app)
    if app then
      app = app:match("^%s*(.-)%s*$")
      update_front_app(app)
    end
  end)
end)
