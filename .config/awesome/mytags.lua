tags = {}
for s = 2, screen.count() do
    tags[s] = {}
    for tagnumber = 1, 2 do
        tags[s][tagnumber] = tag({ name = tagnumber, layout ="floating"  })
        tags[s][tagnumber].screen = s
    end
    tags[s][1].selected = true
end

tags[1] = {}
tags[1][1] = tag({ name = "main", layout = layouts[1] })
tags[1][1].mwfact = 0.5
tags[1][1].screen = 1

tags[1][2] = tag({ name = "www", layout = layouts[1] })
tags[1][2].mwfact = 0.5
tags[1][2].screen = 1

tags[1][3] = tag({ name = "stuff", layout = "floating"})
tags[1][3].mwfact = 0.6
tags[1][3].screen = 1

tags[1][4] = tag({ name = "work", layout = layouts[1] })
tags[1][4].mwfact = 0.6
tags[1][4].screen = 1

tags[1][5] = tag({ name = "virt", layout = "max" })
tags[1][5].mwfact = 0.6
tags[1][5].screen = 1

tags[1][6] = tag({ name = "etc", layout = "floating" })
tags[1][6].mwfact = 0.6
tags[1][6].screen = 1
tags[1][1].selected = true

-- vim: set filetype=lua fdm=marker tabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent nu:
