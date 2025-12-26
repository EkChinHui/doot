local colors = require("colors")
local settings = require("settings")

-- Pomodoro settings (in seconds)
local WORK_TIME = 25 * 60
local SHORT_BREAK = 5 * 60
local LONG_BREAK = 15 * 60
local POMODOROS_UNTIL_LONG_BREAK = 4

-- State
local time_remaining = WORK_TIME
local is_running = false
local is_break = false
local pomodoro_count = 0
local timer_interval = nil

local pomodoro = sbar.add("item", "pomodoro", {
  position = "right",
  icon = {
    string = "󰔛",
    font = {
      family = settings.font,
      size = 16.0,
    },
    color = colors.red,
    padding_left = 6,
    padding_right = 4,
  },
  label = {
    string = "25:00",
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
  padding_left = 2,
  padding_right = 2,
  update_freq = 0,
})

local function format_time(seconds)
  local mins = math.floor(seconds / 60)
  local secs = seconds % 60
  return string.format("%02d:%02d", mins, secs)
end

local function update_display()
  local icon, icon_color

  if is_break then
    icon = "󰒲"  -- break/coffee icon
    icon_color = colors.green
  elseif is_running then
    icon = "󰔛"  -- timer running
    icon_color = colors.red
  else
    icon = "󰔜"  -- timer paused
    icon_color = colors.fg4
  end

  sbar.animate("quadratic", 10, function()
    pomodoro:set({
      icon = { string = icon, color = icon_color },
      label = { string = format_time(time_remaining) },
    })
  end)
end

local function notify(title, message)
  sbar.exec(string.format(
    'osascript -e \'display notification "%s" with title "%s" sound name "Glass"\'',
    message, title
  ))
end

local function start_break()
  is_break = true
  if pomodoro_count >= POMODOROS_UNTIL_LONG_BREAK then
    time_remaining = LONG_BREAK
    pomodoro_count = 0
    notify("Pomodoro", "Time for a long break! (15 min)")
  else
    time_remaining = SHORT_BREAK
    notify("Pomodoro", "Time for a short break! (5 min)")
  end
  update_display()
end

local function start_work()
  is_break = false
  time_remaining = WORK_TIME
  notify("Pomodoro", "Break over! Back to work.")
  update_display()
end

local function tick()
  if not is_running then return end

  time_remaining = time_remaining - 1

  if time_remaining <= 0 then
    if is_break then
      start_work()
    else
      pomodoro_count = pomodoro_count + 1
      start_break()
    end
  else
    update_display()
  end
end

local function toggle_timer()
  is_running = not is_running

  if is_running then
    pomodoro:set({ update_freq = 1 })
  else
    pomodoro:set({ update_freq = 0 })
  end

  update_display()
end

local function reset_timer()
  is_running = false
  is_break = false
  time_remaining = WORK_TIME
  pomodoro_count = 0
  pomodoro:set({ update_freq = 0 })
  update_display()
  notify("Pomodoro", "Timer reset")
end

local function skip_phase()
  if is_break then
    start_work()
  else
    pomodoro_count = pomodoro_count + 1
    start_break()
  end
end

-- Left click: start/pause
pomodoro:subscribe("mouse.clicked", function(env)
  if env.BUTTON == "left" then
    toggle_timer()
  elseif env.BUTTON == "right" then
    reset_timer()
  end
end)

-- Routine update (called every second when running)
pomodoro:subscribe("routine", tick)

-- Initial display
update_display()
