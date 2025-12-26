local colors = require("colors")
local settings = require("settings")

local whitelist = {
  ["Spotify"] = true,
  ["Music"] = true,
}

local media = sbar.add("item", "media", {
  icon = {
    string = "󰎆",
    font = {
      family = settings.font,
      size = 16.0,
    },
    color = colors.green,
    padding_left = 8,
    padding_right = 4,
  },
  label = {
    font = {
      family = settings.font,
      style = "Medium",
      size = 13.0,
    },
    color = colors.fg2,
    max_chars = 40,
    padding_left = 0,
    padding_right = 8,
  },
  background = {
    color = colors.bg1,
    corner_radius = 6,
    height = 26,
  },
  position = "center",
  drawing = false,
  updates = true,
  padding_left = 4,
  padding_right = 4,
})

media:subscribe("media_change", function(env)
  if whitelist[env.INFO.app] then
    local playing = env.INFO.state == "playing"
    local artist = env.INFO.artist or ""
    local title = env.INFO.title or ""
    local display = ""

    if artist ~= "" and title ~= "" then
      display = artist .. " - " .. title
    elseif title ~= "" then
      display = title
    end

    sbar.animate("quadratic", 10, function()
      media:set({
        drawing = playing,
        icon = { string = playing and "󰎆" or "󰏥" },
        label = { string = display },
      })
    end)
  end
end)
