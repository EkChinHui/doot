local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local battery = sbar.add("item", "battery", {
  position = "right",
  icon = {
    font = {
      style = "Regular",
      size = 18.0,
    },
    color = colors.fg1,
    padding_left = 6,
    padding_right = 2,
  },
  label = {
    font = {
      family = settings.font,
      style = "Medium",
      size = 13.0,
    },
    color = colors.fg3,
    padding_left = 0,
    padding_right = 6,
  },
  background = {
    color = colors.bg1,
    corner_radius = 6,
    height = 26,
  },
  update_freq = 120,
  padding_left = 2,
  padding_right = 4,
})

local function battery_update()
  sbar.exec("pmset -g batt", function(batt_info)
    local icon = "!"
    local label = ""
    local icon_color = colors.fg1
    local charging = string.find(batt_info, 'AC Power')

    local found, _, charge = batt_info:find("(%d+)%%")
    if found then
      charge = tonumber(charge)
      label = charge .. "%"
    end

    if charging then
      icon = icons.battery.charging
      icon_color = colors.green
    elseif found and charge > 80 then
      icon = icons.battery._100
      icon_color = colors.green
    elseif found and charge > 60 then
      icon = icons.battery._75
      icon_color = colors.fg1
    elseif found and charge > 40 then
      icon = icons.battery._50
      icon_color = colors.yellow
    elseif found and charge > 20 then
      icon = icons.battery._25
      icon_color = colors.orange
    else
      icon = icons.battery._0
      icon_color = colors.red
    end

    sbar.animate("quadratic", 15, function()
      battery:set({
        icon = { string = icon, color = icon_color },
        label = { string = label },
      })
    end)
  end)
end

battery:subscribe({"routine", "power_source_change", "system_woke"}, battery_update)
