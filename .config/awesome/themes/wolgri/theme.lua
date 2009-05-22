-------------------------------
--    "Wolgri" awesome theme    --
-------------------------------
theme = {}

-- BASICS
theme.font          = "Profont 8"

theme.bg_focus      = "#737373"
theme.bg_normal     = "#4D4D4D"
theme.bg_urgent     = "#737373"

theme.fg_normal     = "#CCCCCC"
theme.fg_focus      = "#E5E5E5"
theme.fg_urgent     = "#7F7F7F"


theme.border_width  = "2"
theme.border_normal = "#4D4D4D"
theme.border_focus  = "#B3B3B3"

theme.border_marked = "#FFA500"

theme.color_green = "#00FF00"
theme.color_red   = "#FF0000"
theme.color_cyan  = "#00FFFF"
theme.bat_fg      = "#5F9EA0"

-- IMAGES
theme.layout_fairh		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/fairh.png"
theme.layout_fairv		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/fairv.png"
theme.layout_floating		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/floating.png"
theme.layout_magnifier		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/magnifier.png"
theme.layout_max		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/max.png"
theme.layout_fullscreen		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/fullscreen.png"
theme.layout_tilebottom		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/tilebottom.png"
theme.layout_tileleft		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/tileleft.png"
theme.layout_tile		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/tile.png"
theme.layout_tiletop		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/tiletop.png"
theme.layout_vilebottom		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/vilebottom.png"
theme.layout_vileleft		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/vileleft.png"
theme.layout_vile		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/vile.png"
theme.layout_viletop		= "/home/wolgri/.config/awesome/themes/wolgri/layouts/viletop.png"

-- Define the image to load
theme.titlebar_close_button_normal	= "/home\/wolgri/.config/awesome/themes/wolgri/titlebar/close.png"
theme.titlebar_close_button_focus	= "/home\/wolgri/.config/awesome/themes/wolgri/titlebar/closer.png"


theme.awesome_icon		= "/home/wolgri/.config/awesome/themes/wolgri/awesome-icon.png"
theme.tasklist_floating_icon	= "/home/wolgri/.config/awesome/themes/wolgri/layouts/floating.png"

-- from default for now...
theme.menu_submenu_icon		= "/usr/share/awesome/themes/default/submenu.png"
theme.taglist_squares_sel	= "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel	= "/usr/share/awesome/themes/default/taglist/squarew.png"

-- MISC
theme.wallpaper_cmd		= {"xsetroot -solid '#222222'"}

theme.taglist_squares		= "true"
theme.titlebar_close_button	= "true"
theme.menu_height		= "24"
theme.menu_width		= "120"
return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
