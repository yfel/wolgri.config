--{{{ Deffault crap 
if usetags=="mytags" then 

	tags = {}
	for s = 2, screen.count() do
	    tags[s] = {}
	    for tagnumber = 1, 2 do
		tags[s][tagnumber] = tag(tagnumber)
		tags[s][tagnumber].screen = s
		awful.layout.set(awful.layout.suit.floating, tags[s][tagnumber])
	    end
	    tags[s][1].selected = true
	end

	tags[1] = {}

	tags[1][1] = tag("main")
	tags[1][1].screen = 1
	awful.layout.set(layouts[1], tags[1][1])
	tags[1][1].selected = true

	tags[1][2] = tag("web")
	tags[1][2].screen = 1
	awful.layout.set(layouts[1], tags[1][2])

	tags[1][3] = tag("stuff")
	tags[1][3].screen = 1
	awful.layout.set(awful.layout.suit.floating, tags[1][3])

	tags[1][4] = tag("work")
	tags[1][4].screen = 1
	awful.layout.set(layouts[1], tags[1][4])

	tags[1][5] = tag("virt")
	tags[1][5].screen = 1
	awful.layout.set(awful.layout.suit.tile.max, tags[1][5])

	tags[1][6] = tag("etc")
	tags[1][6].screen = 1
	awful.layout.set(layouts[1], tags[1][6])

	tags[1][1].selected = true
end
--}}}
--{{{ Shifty
if usetags=="shifty" then 
	require('shifty')
	shifty.config.tags = {
	   ["1:sys"] = { init = true, position = 1, screen = 1, mwfact = 0.60                 },
	   ["3:www"] = { exclusive = true, solitary = true, position = 3, spawn = "firefox"   },
	  ["2:term"] = { persist = true, position = 2,                                        },
	  ["ardour"] = { nopopup = true, leave_kills = true,                                  },
	     ["p2p"] = { icon = "/usr/share/pixmaps/p2p.png", notext = true,                  },
	    ["gimp"] = { layout = "tile", mwfact = 0.18, icon="/usr/share/pixmaps/gimp.png",  },
	      ["fs"] = { rel_index = 1,                                                       },
	}

	shifty.config.apps = {
		{ match = { "htop", "Wicd", "jackctl"       }, tag = "1:sys",        screen = 1,     },
		{ match = {"Iceweasel.*", "Firefox.*"       }, tag = "3:www",                        },
		{ match = {"urxvt"                          }, tag = "2:term",       screen = 1,     },
		{ match = {"Gimp","Ufraw"                   }, tag = "gimp",                         },
		{ match = {"gimp-image-window"              }, slave = true,                         },
		{ match = {"gcolor2", "xmag"                }, intrusive = true,                     },
		{ match = {"gcolor2"                        }, geometry = { x = 100, y = 100 },      },
		{ match = {"recordMyDesktop", "MPlayer", "xmag", }, float = true,                         },

	}

	shifty.config.defaults = {
	  layout = "max", 
	  run = function(tag) naughty.notify({ text = tag.name }) end,
	}

	shifty.init()
end
--}}}
