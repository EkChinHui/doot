local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local volume_slider = sbar.add("slider", "volume.slider", 100, {
  position = "right",
  updates = true,
  label = { drawing = false },
  icon = { drawing = false },
  slider = {
    highlight_color = colors.yellow,
    width = 0,
    background = {
      height = 6,
      corner_radius = 3,
      color = colors.bg3,
    },
    knob = {
      string = "󰝟",
      font = { size = 14.0 },
      color = colors.yellow,
      drawing = false,
    },
  },
  background = { drawing = false },
  padding_left = 0,
  padding_right = 0,
})

local volume_icon = sbar.add("item", "volume.icon", {
  position = "right",
  icon = {
    string = icons.volume._100,
    font = {
      style = "Regular",
      size = 16.0,
    },
    color = colors.yellow,
    padding_left = 6,
    padding_right = 6,
  },
  label = { drawing = false },
  background = {
    color = colors.bg1,
    corner_radius = 6,
    height = 26,
  },
  padding_left = 2,
  padding_right = 2,
})

volume_slider:subscribe("mouse.clicked", function(env)
  sbar.exec("osascript -e 'set volume output volume " .. env["PERCENTAGE"] .. "'")
end)

volume_slider:subscribe("volume_change", function(env)
  local volume = tonumber(env.INFO)
  local icon = icons.volume._0
  if volume > 60 then
    icon = icons.volume._100
  elseif volume > 30 then
    icon = icons.volume._66
  elseif volume > 10 then
    icon = icons.volume._33
  elseif volume > 0 then
    icon = icons.volume._10
  end

  sbar.animate("quadratic", 10, function()
    volume_icon:set({ icon = { string = icon } })
    volume_slider:set({ slider = { percentage = volume } })
  end)
end)

local function animate_slider_width(width)
  sbar.animate("quadratic", 20.0, function()
    volume_slider:set({
      slider = {
        width = width,
        knob = { drawing = width > 0 },
      },
    })
  end)
end

volume_icon:subscribe("mouse.clicked", function()
  if tonumber(volume_slider:query().slider.width) > 0 then
    animate_slider_width(0)
  else
    animate_slider_width(80)
  end
end)
