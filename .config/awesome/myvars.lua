terminal = "urxvt"
home_dir = os.getenv("HOME")
--{{{ Beutiful
theme_path = awful.util.getdir("config") .. "/themes/wolgri/theme"
beautiful.init(theme_path)
--}}}
floatapps = {}
floatapps =
{
    -- by class
    ["MPlayer"] = true,
    ["pinentry"] = true,
--    ["gimp"] = true,
    ["wicd-client.py"] = true,

    -- by instance
    ["mocp"] = true
}

-- Applications to be moved to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
apptags = {}
apptags =
{
     ["Swiftfox"] = { screen = 1, tag = 2 },
     ["lilyterm"] = { screen = 1, tag = 1 },
     ["vmware"] = { screen = 1, tag = 5 },
     ["VirtualBox"] = { screen = 1, tag = 5 },
     ["gajim.py"] = { screen = 1, tag = 3 },


}
layouts ={}
layouts =
{
    awful.layout.suit.tile,
--    awful.layout.suit.tile.left,
--    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
--    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
--    awful.layout.suit.max.fullscreen,
--    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

-- vim: set filetype=lua fdm=marker tabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent nu:
