local wezterm = require "wezterm"


local colors = {
  primary = "{{ $primary }}",
  secondary = "{{ $secondary }}",
  background = "{{ $background }}",
  onBackground = "{{ $onBackground }}",
}


return {
  colors = {
    foreground = colors.onBackground,
    background = colors.background,
    cursor_bg = colors.onBackground,
    cursor_fg = colors.background,
    cursor_border = colors.onBackground,

    ansi = {
      colors.background,     -- 0
      colors.secondary,      -- 1
      colors.primary,        -- 2
      colors.secondary,      -- 3
      colors.primary,        -- 4
      "#9AA7C8",             -- 5
      "#ABD4EA",             -- 6
      colors.onBackground,   -- 7
    },
    brights = {
      "#9ca3a8",             -- 8
      colors.secondary,      -- 9
      colors.primary,        -- 10
      colors.secondary,      -- 11
      colors.primary,        -- 12
      "#9AA7C8",             -- 13
      "#ABD4EA",             -- 14
      colors.onBackground,   -- 15
    },
  },
}
