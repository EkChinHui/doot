local colors = require("colors")
local settings = require("settings")
local app_icons = require("helper.app_icons")

-- Register the aerospace custom event so sketchybar can receive it
sbar.add("event", "aerospace_workspace_change")

local function parse_string_to_table(s)
  local result = {}
  for line in s:gmatch("([^\n]+)") do
    table.insert(result, line)
  end
  return result
end

-- Check if aerospace is available
local function aerospace_available()
  local handle = io.popen("which aerospace 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  return result ~= ""
end

if not aerospace_available() then
  -- Fallback: just show a simple placeholder
  sbar.add("item", "spaces.placeholder", {
    icon = {
      string = "󰍹",
      color = colors.fg4,
      padding_left = 8,
      padding_right = 8,
    },
    label = { drawing = false },
    background = {
      color = colors.bg1,
      corner_radius = 6,
      height = 26,
    },
    padding_left = 4,
  })
  require("items.front_app")
  return
end

-- Left bracket for workspace group
local spaces_bracket_left = sbar.add("item", "spaces.bracket.left", {
  icon = { drawing = false },
  label = { drawing = false },
  background = { drawing = false },
  padding_left = 4,
  padding_right = 0,
})

local workspace_items = {}
local workspaces = {}
local workspace_monitors = {}

-- Query workspaces with monitor info
sbar.exec("aerospace list-workspaces --all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json 2>/dev/null", function(workspaces_json)
  if not workspaces_json or type(workspaces_json) ~= "table" then return end

  for _, entry in ipairs(workspaces_json) do
    local workspace = entry.workspace
    local monitor_id = entry["monitor-appkit-nsscreen-screens-id"]

    -- Skip workspace "c"
    if workspace == "c" then
      goto continue
    end

    -- Position workspace "x" on the right side
    local position = (workspace == "x") and "right" or "left"

    local space = sbar.add("item", "space." .. workspace, {
      position = position,
      display = monitor_id,
    icon = {
      string = workspace,
      font = {
        family = settings.font,
        style = "Bold",
        size = 15.0,
      },
      color = colors.fg4,
      highlight_color = colors.orange,
      padding_left = 8,
      padding_right = 4,
    },
    label = {
      font = "sketchybar-app-font:Regular:16.0",
      color = colors.fg4,
      highlight_color = colors.fg1,
      y_offset = -1,
      padding_left = 0,
      padding_right = 8,
      drawing = false,
    },
    background = {
      color = colors.bg1,
      corner_radius = 6,
      height = 26,
      drawing = true,
    },
    padding_left = 2,
    padding_right = 2,
    click_script = "aerospace workspace " .. workspace,
  })

  workspace_items[workspace] = space
  table.insert(workspaces, workspace)

  space:subscribe("aerospace_workspace_change", function(env)
    local selected = env.FOCUSED_WORKSPACE == workspace
    sbar.animate("quadratic", 10, function()
      space:set({
        icon = { highlight = selected },
        label = { highlight = selected },
        background = {
          color = selected and colors.bg2 or colors.bg1,
          border_width = selected and 1 or 0,
          border_color = colors.orange,
        },
      })
    end)
  end)

  ::continue::
  end

  -- Function to update workspace app icons and visibility
  local function update_workspace_icons()
    sbar.exec("aerospace list-workspaces --focused 2>/dev/null", function(focused)
      focused = focused and focused:match("^%s*(.-)%s*$") or ""

      sbar.exec("aerospace list-windows --all --format '%{workspace}%{app-name}' --json 2>/dev/null", function(windows_json)
        if not windows_json or type(windows_json) ~= "table" then return end
        local workspace_apps = {}

        for _, entry in ipairs(windows_json) do
          local ws = entry.workspace
          local app = entry["app-name"]
          if workspace_apps[ws] == nil then
            workspace_apps[ws] = {}
          end
          table.insert(workspace_apps[ws], app)
        end

        for _, ws in ipairs(workspaces) do
          local apps = workspace_apps[ws]
          local icon_line = ""
          local has_apps = apps and #apps > 0
          local is_focused = ws == focused

          if has_apps then
            for j, app in ipairs(apps) do
              if j <= 4 then -- Max 4 icons per workspace
                local lookup = app_icons[app]
                local icon = lookup or app_icons["Default"]
                icon_line = icon_line .. icon .. " "
              end
            end
            workspace_items[ws]:set({
              drawing = true,
              label = { string = icon_line, drawing = true },
            })
          elseif is_focused then
            -- Show focused workspace even if empty
            workspace_items[ws]:set({
              drawing = true,
              label = { drawing = false },
            })
          else
            -- Hide empty, unfocused workspaces
            workspace_items[ws]:set({
              drawing = false,
            })
          end
        end
      end)
    end)
  end

  -- Function to update workspace monitor assignments
  local function update_workspace_monitors()
    sbar.exec("aerospace list-workspaces --all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json 2>/dev/null", function(monitors_json)
      if not monitors_json or type(monitors_json) ~= "table" then return end
      for _, entry in ipairs(monitors_json) do
        local ws = entry.workspace
        local monitor_id = entry["monitor-appkit-nsscreen-screens-id"]
        if workspace_items[ws] then
          workspace_items[ws]:set({ display = monitor_id })
        end
      end
    end)
  end

  -- Subscribe to window events
  spaces_bracket_left:subscribe("aerospace_workspace_change", function()
    update_workspace_icons()
    update_workspace_monitors()
  end)
  spaces_bracket_left:subscribe("front_app_switched", update_workspace_icons)
  spaces_bracket_left:subscribe("space_windows_change", update_workspace_icons)
  spaces_bracket_left:subscribe("display_change", function()
    -- Delay to let aerospace reassign workspaces to new monitor config
    sbar.exec("sleep 0.5 && echo done", function()
      update_workspace_monitors()
      update_workspace_icons()
    end)
  end)

  -- Initial update
  update_workspace_icons()

  -- Set initial focused state
  sbar.exec("aerospace list-workspaces --focused 2>/dev/null", function(focused)
    if not focused or focused == "" then return end
    focused = focused:match("^%s*(.-)%s*$")
    if workspace_items[focused] then
      workspace_items[focused]:set({
        icon = { highlight = true },
        label = { highlight = true },
        background = {
          color = colors.bg2,
          border_width = 1,
          border_color = colors.orange,
        },
      })
    end
  end)

  -- Load front_app after workspaces are created
  require("items.front_app")
end)
