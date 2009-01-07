terminal = "urxvt"
floatapps = {}
floatapps =
{
    -- by class
    ["MPlayer"] = true,
    ["pinentry"] = true,
    ["gimp"] = true,
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
    "tile",
--    "tileleft",
--    "tilebottom",
    "tiletop",
    "fairh",
--    "fairv",
--    "magnifier",
    "max",
--    "fullscreen",
--    "spiral",
--    "dwindle",
    "floating"
}
-- vim: set filetype=lua fdm=marker tabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent nu:
