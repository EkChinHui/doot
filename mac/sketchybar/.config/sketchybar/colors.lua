-- Gruvbox Dark colors
local M = {}

-- Base colors
M.black = 0xff282828
M.white = 0xffebdbb2
M.red = 0xfffb4934
M.green = 0xffb8bb26
M.blue = 0xff83a598
M.yellow = 0xfffabd2f
M.orange = 0xfffe8019
M.magenta = 0xffd3869b
M.aqua = 0xff8ec07c
M.grey = 0xff928374
M.transparent = 0x00000000

-- Background shades
M.bg0 = 0xff282828
M.bg1 = 0xff3c3836
M.bg2 = 0xff504945
M.bg3 = 0xff665c54
M.bg4 = 0xff7c6f64

-- Foreground shades
M.fg0 = 0xfffbf1c7
M.fg1 = 0xffebdbb2
M.fg2 = 0xffd5c4a1
M.fg3 = 0xffbdae93
M.fg4 = 0xffa89984

-- Bar styling
M.bar = {
  bg = 0xf0282828,
  border = 0xff3c3836,
}
M.popup = {
  bg = 0xff282828,
  border = 0xffebdbb2
}

-- Helper function for alpha blending
M.with_alpha = function(color, alpha)
  if alpha > 1.0 or alpha < 0.0 then return color end
  return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

return M
