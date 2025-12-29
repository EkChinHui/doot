local colors = require("colors")
local settings = require("settings")

-- Pomodoro settings (in seconds) - these are mutable
local config = {
  work_time = 25 * 60,
  short_break = 5 * 60,
  long_break = 15 * 60,
  pomodoros_until_long_break = 4,
}

-- Presets for quick selection
local WORK_PRESETS = { 15, 25, 45, 60 }  -- minutes
local BREAK_PRESETS = { 5, 10, 15, 20 }  -- minutes

-- State
local time_remaining = config.work_time
local is_running = false
local is_break = false
local pomodoro_count = 0
local timer_interval = nil
local is_expanded = false
local popup_open = false

-- Items to hide when expanded
local RIGHT_SIDE_ITEMS = {
  "calendar",
  "battery",
  "volume.icon",
  "volume.slider",
  "cpu",
  "ram",
}

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
  popup = {
    align = "right",
    height = 30,
    background = {
      color = colors.bg0,
      corner_radius = 8,
      border_color = colors.bg3,
      border_width = 1,
    },
  },
})

-- Pomodoro count display (only visible when expanded)
local pomodoro_dots = sbar.add("item", "pomodoro.dots", {
  position = "right",
  icon = { drawing = false },
  label = {
    string = "",
    font = {
      family = settings.font,
      size = 12.0,
    },
    color = colors.fg4,
    padding_left = 8,
    padding_right = 4,
  },
  background = { drawing = false },
  drawing = false,
})

-- Popup menu items
local popup_items = {}
local update_popup_selection  -- forward declaration

-- Helper to create a popup item
local function create_popup_item(name, label, is_header)
  local item = sbar.add("item", name, {
    position = "popup." .. pomodoro.name,
    icon = { drawing = false },
    label = {
      string = label,
      font = {
        family = settings.font,
        style = is_header and "Bold" or "Medium",
        size = is_header and 11.0 or 13.0,
      },
      color = is_header and colors.fg4 or colors.fg1,
      padding_left = 12,
      padding_right = 12,
    },
    background = {
      color = colors.transparent,
      height = is_header and 24 or 28,
    },
  })
  return item
end

-- Work time header
create_popup_item("pomodoro.popup.work_header", "WORK TIME", true)

-- Work time presets
for _, mins in ipairs(WORK_PRESETS) do
  local item_name = "pomodoro.popup.work_" .. mins
  local item = create_popup_item(item_name, mins .. " min", false)
  popup_items[item_name] = { item = item, mins = mins, type = "work" }

  item:subscribe("mouse.clicked", function()
    config.work_time = mins * 60
    if not is_running and not is_break then
      time_remaining = config.work_time
    end
    update_popup_selection()
    update_display()
  end)

  item:subscribe("mouse.entered", function()
    item:set({ background = { color = colors.bg2 } })
  end)

  item:subscribe("mouse.exited", function()
    item:set({ background = { color = colors.transparent } })
  end)
end

-- Break time header
create_popup_item("pomodoro.popup.break_header", "SHORT BREAK", true)

-- Break time presets
for _, mins in ipairs(BREAK_PRESETS) do
  local item_name = "pomodoro.popup.break_" .. mins
  local item = create_popup_item(item_name, mins .. " min", false)
  popup_items[item_name] = { item = item, mins = mins, type = "break" }

  item:subscribe("mouse.clicked", function()
    config.short_break = mins * 60
    update_popup_selection()
  end)

  item:subscribe("mouse.entered", function()
    item:set({ background = { color = colors.bg2 } })
  end)

  item:subscribe("mouse.exited", function()
    item:set({ background = { color = colors.transparent } })
  end)
end

-- Divider
create_popup_item("pomodoro.popup.divider", "───────────", true)

-- Reset button
local reset_item = create_popup_item("pomodoro.popup.reset", "󰜉  Reset Timer", false)
reset_item:set({ label = { color = colors.red } })

reset_item:subscribe("mouse.clicked", function()
  pomodoro:set({ popup = { drawing = false } })
  popup_open = false
  -- Call reset after closing popup
  is_running = false
  is_break = false
  time_remaining = config.work_time
  pomodoro_count = 0
  pomodoro:set({ update_freq = 0 })
  set_expanded(false)
  update_display()
end)

reset_item:subscribe("mouse.entered", function()
  reset_item:set({ background = { color = colors.bg2 } })
end)

reset_item:subscribe("mouse.exited", function()
  reset_item:set({ background = { color = colors.transparent } })
end)

-- Helper to update checkmarks on popup items
update_popup_selection = function()
  for name, data in pairs(popup_items) do
    local is_selected = false
    if data.type == "work" then
      is_selected = (data.mins * 60 == config.work_time)
    elseif data.type == "break" then
      is_selected = (data.mins * 60 == config.short_break)
    end
    local prefix = is_selected and "󰄬  " or "    "
    data.item:set({
      label = {
        string = prefix .. data.mins .. " min",
        color = is_selected and colors.green or colors.fg1,
      },
    })
  end
end

local function format_time(seconds)
  local mins = math.floor(seconds / 60)
  local secs = seconds % 60
  return string.format("%02d:%02d", mins, secs)
end

local function get_dots_string()
  local dots = ""
  for i = 1, config.pomodoros_until_long_break do
    if i <= pomodoro_count then
      dots = dots .. "󰝥 "  -- filled circle
    else
      dots = dots .. "󰝦 "  -- empty circle
    end
  end
  return dots
end

local function set_expanded(expanded)
  if is_expanded == expanded then return end
  is_expanded = expanded

  sbar.animate("quadratic", 15, function()
    -- Hide/show other right-side items
    for _, item_name in ipairs(RIGHT_SIDE_ITEMS) do
      sbar.set(item_name, { drawing = not expanded })
    end

    -- Update pomodoro styling based on expanded state
    if expanded then
      pomodoro:set({
        icon = {
          font = { size = 24.0 },
          padding_left = 12,
          padding_right = 8,
        },
        label = {
          font = { size = 22.0, style = "Semibold" },
          padding_right = 12,
        },
        background = {
          height = 32,
          corner_radius = 8,
        },
        padding_right = 6,
      })
      pomodoro_dots:set({
        drawing = true,
        label = { string = get_dots_string() },
      })
    else
      pomodoro:set({
        icon = {
          font = { size = 16.0 },
          padding_left = 6,
          padding_right = 4,
        },
        label = {
          font = { size = 13.0, style = "Medium" },
          padding_right = 6,
        },
        background = {
          height = 26,
          corner_radius = 6,
        },
        padding_right = 2,
      })
      pomodoro_dots:set({ drawing = false })
    end
  end)
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
    -- Update dots when expanded
    if is_expanded then
      pomodoro_dots:set({ label = { string = get_dots_string() } })
    end
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
  if pomodoro_count >= config.pomodoros_until_long_break then
    time_remaining = config.long_break
    pomodoro_count = 0
    notify("Pomodoro", "Time for a long break! (" .. math.floor(config.long_break / 60) .. " min)")
  else
    time_remaining = config.short_break
    notify("Pomodoro", "Time for a short break! (" .. math.floor(config.short_break / 60) .. " min)")
  end
  update_display()
end

local function start_work()
  is_break = false
  time_remaining = config.work_time
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
    set_expanded(true)
  else
    pomodoro:set({ update_freq = 0 })
    set_expanded(false)
  end

  update_display()
end

local function reset_timer()
  is_running = false
  is_break = false
  time_remaining = config.work_time
  pomodoro_count = 0
  pomodoro:set({ update_freq = 0 })
  set_expanded(false)
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

-- Toggle popup
local function toggle_popup()
  popup_open = not popup_open
  if popup_open then
    update_popup_selection()
  end
  pomodoro:set({ popup = { drawing = popup_open } })
end

-- Left click: start/pause, Right click: open config menu
pomodoro:subscribe("mouse.clicked", function(env)
  if env.BUTTON == "left" then
    toggle_timer()
  elseif env.BUTTON == "right" then
    toggle_popup()
  end
end)

-- Close popup when clicking elsewhere
pomodoro:subscribe("mouse.exited.global", function()
  if popup_open then
    popup_open = false
    pomodoro:set({ popup = { drawing = false } })
  end
end)

-- Routine update (called every second when running)
pomodoro:subscribe("routine", tick)

-- Initial display
update_display()
