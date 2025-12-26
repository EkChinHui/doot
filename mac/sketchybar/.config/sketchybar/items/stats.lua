local colors = require("colors")
local settings = require("settings")

-- CPU item
local cpu = sbar.add("item", "cpu", {
  position = "right",
  icon = {
    string = "󰻠",
    font = {
      family = settings.font,
      size = 16.0,
    },
    color = colors.blue,
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
  update_freq = 2,
  padding_left = 2,
  padding_right = 2,
})

-- RAM item
local ram = sbar.add("item", "ram", {
  position = "right",
  icon = {
    string = "󰍛",
    font = {
      family = settings.font,
      size = 16.0,
    },
    color = colors.magenta,
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
  update_freq = 4,
  padding_left = 2,
  padding_right = 2,
})

-- CPU update function
local function cpu_update()
  sbar.exec("top -l 1 -n 0 | grep 'CPU usage' | awk '{print $3}' | tr -d '%'", function(result)
    local usage = tonumber(result) or 0
    usage = math.floor(usage)
    local color = colors.fg3
    if usage > 80 then
      color = colors.red
    elseif usage > 50 then
      color = colors.yellow
    end
    sbar.animate("quadratic", 10, function()
      cpu:set({
        label = { string = usage .. "%", color = color },
      })
    end)
  end)
end

-- RAM update function
local function ram_update()
  sbar.exec([[
    memory_pressure | grep "System-wide memory free percentage:" | awk '{print 100 - $5}' | tr -d '%'
  ]], function(result)
    local usage = tonumber(result) or 0
    usage = math.floor(usage)
    local color = colors.fg3
    if usage > 80 then
      color = colors.red
    elseif usage > 60 then
      color = colors.yellow
    end
    sbar.animate("quadratic", 10, function()
      ram:set({
        label = { string = usage .. "%", color = color },
      })
    end)
  end)
end

cpu:subscribe("routine", cpu_update)
ram:subscribe("routine", ram_update)
