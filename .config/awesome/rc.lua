-- awesome 3 configuration file

-- Include awesome library, with lots of useful function!
require("awful")
require("tabulous")
require("beautiful")
require("wicked")

-- {{{ Variable definitions
-- This is a file path to a theme file which will defines colors.
theme_path = "/usr/local/share/awesome/themes/default"

-- This is used later as the default terminal to run.
terminal = "urxvt"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    "tile",
--    "tileleft",
--    "tilebottom",
    "tiletop",
--    "magnifier",
    "max",
--    "spiral",
--    "dwindle",
    "floating"
}

-- Table of clients that should be set floating. The index may be either
-- the application class or instance. The instance is useful when running
-- a console app in a terminal like (Music on Console)
--    xterm -name mocp -e mocp
floatapps =
{
    -- by class
    ["MPlayer"] = true,
    ["pinentry"] = true,
    ["gimp"] = true,
    -- by instance
    ["mocp"] = true
}

-- Applications to be moved to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
apptags =
{
     ["Swiftfox"] = { screen = 1, tag = 2 },
     ["lilyterm"] = { screen = 1, tag = 1 },
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}

-- {{{ Initialization
-- Initialize theme (colors).
beautiful.init(theme_path)

-- Register theme in awful.
-- This allows to not pass plenty of arguments to each function
-- to inform it about colors we want it to draw.
awful.beautiful.register(beautiful)

-- Enable prompt history
awful.prompt.history.set()

-- Uncomment this to activate autotabbing
-- tabulous.autotab_start()
-- }}}

-- {{{ Tags
-- Define tags table.
tags = {}
tags[1]= {}
tags[1][1] = tag({ name = "main", layout = layouts[1] })
tags[1][1].mwfact = 0.5
tags[1][1].screen = 1

tags[1][2] = tag({ name = "www", layout = layouts[1] })
tags[1][2].mwfact = 0.5
tags[1][2].screen = 1

tags[1][3] = tag({ name = "stuff", layout = layouts[1] })
tags[1][3].mwfact = 0.6
tags[1][3].screen = 1

tags[1][4] = tag({ name = "work", layout = layouts[1] })
tags[1][4].mwfact = 0.6
tags[1][4].screen = 1

tags[1][5] = tag({ name = "virt", layout = layouts[4] })
tags[1][5].mwfact = 0.6
tags[1][5].screen = 1

tags[1][6] = tag({ name = "etc", layout = layouts[4] })
tags[1][6].mwfact = 0.6
tags[1][6].screen = 1

tags[1][1].selected = true
-- }}}

-- {{{ Statusbar
--{{{ Create a taglist widget
mytaglist = widget({ type = "taglist", name = "mytaglist" })
mytaglist:mouse_add(mouse({}, 1, function (object, tag) awful.tag.viewonly(tag) end))
mytaglist:mouse_add(mouse({ modkey }, 1, function (object, tag) awful.client.movetotag(tag) end))
mytaglist:mouse_add(mouse({}, 3, function (object, tag) tag.selected = not tag.selected end))
mytaglist:mouse_add(mouse({ modkey }, 3, function (object, tag) awful.client.toggletag(tag) end))
mytaglist:mouse_add(mouse({ }, 4, awful.tag.viewnext))
mytaglist:mouse_add(mouse({ }, 5, awful.tag.viewprev))
mytaglist.label = awful.widget.taglist.label.all
--}}}
--{{{ Spacer
tb_spacer= widget({ type = 'textbox', name = 'tb_spacer',align = 'right' })
tb_spacer.width = "4"
tb_spacer.text = " "

tb_space= widget({ type = 'textbox', name = 'tb_space'})
tb_space.width = "4"
tb_space.text = " "
--}}}
--{{{ Batt
battarywidget = widget({ type = 'progressbar', name = 'battarywidget' })
battarywidget.width = 25
battarywidget.height = 0.5
battarywidget.gap = 1
battarywidget.border_padding = 1
battarywidget.border_width = 1
battarywidget.ticks_count = 6
battarywidget.ticks_gap = 1
battarywidget.vertical = false
battarywidget:bar_properties_set('bat', {
bg = 'blue',
fg = 'gray',
fg_off = 'blue',
reverse = false,
min_value = 0,
max_value = 100
})
wicked.register(battarywidget, 'bat', function (widget, args)
   local a = io.open("/sys/class/power_supply/BAT1/charge_full")
    for line in a:lines() do
            full = line
       end 
    a:close()
 local b = io.open("/sys/class/power_supply/BAT1/charge_now")
    for line in b:lines() do
            now = line
       end 
    b:close()
batt=math.floor(now*100/full)
return batt
end, 2, 'bat')
--}}}
--{{{ Mhz
mhzwidget = widget({ type = 'textbox', name = 'mhzwidget' , align = 'right' })
wicked.register(mhzwidget, 'mhz', function (widget, args)
    local m = io.popen("cat /proc/cpuinfo|grep MHz|uniq|awk '{print ($4)/1000}'")
      for line in m:lines() do
            return (line)
      end    

    m:close()
end, 1)


--}}}
--{{{ Volume
volumewidget = widget({ type = 'progressbar', name = 'volumewidget' })
volumewidget.width = 40
volumewidget.height = 0.75
volumewidget.gap = 0
volumewidget.border_padding = 1
volumewidget.border_width = 1
volumewidget.ticks_count = 10
volumewidget.ticks_gap = 1
volumewidget.vertical = false
volumewidget:bar_properties_set('vol', {
bg = 'gray50',
fg = 'green',
fg_off = 'gray50',
reverse = false,
min_value = 0,
max_value = 100
})



wicked.register(volumewidget, 'vol', function (widget, args)
   local v = io.popen("amixer sget Master |grep 'Left: Playback'|sed -e 's/[\[,%]/ /g'")

    for line in v:lines() do
        line = splitbywhitespace(line)
            vol = line[5]
       end 
    v:close()
   return vol
end, 2, 'vol')
--}}}
--{{{ Cpu

cpugraphwidget = widget({ type = 'graph', name = 'cpugraphwidget', align = 'right' }) 
cpugraphwidget.height = 0.95
cpugraphwidget.width = 45
cpugraphwidget.bg = '#333333'
cpugraphwidget.border_color = 'gray80'
cpugraphwidget.grow = 'left'

cpugraphwidget:plot_properties_set('cpu', { 
fg = 'red2',
style ='line',
fg_center = 'green', 
fg_end = 'cyan', 
vertical_gradient = true 
})

wicked.register(cpugraphwidget, 'cpu', '$1', 1, 'cpu')
--}}}
--{{{MeM 
membarwidget = widget({ type = 'progressbar', name = 'membarwidget', align = 'right' })

membarwidget.width = 40
membarwidget.height = 0.85
membarwidget.gap = 0
membarwidget.border_padding = 1
membarwidget.border_width = 1
membarwidget.ticks_count = 0
membarwidget.ticks_gap = 0
membarwidget.vertical = false

membarwidget:bar_properties_set('mem', {
bg = 'blue',
fg = 'red',
fg_center = 'red2',
fg_end = 'red3',
fg_off = 'green',
reverse = false,
min_value = 0,
max_value = 100
})

wicked.register(membarwidget, 'mem', '$1', 1, 'mem')
--}}}
--{{{ Wifi
essidwidget = widget({ type = 'textbox', name = 'essidwidget',align = 'right' })
wicked.register(essidwidget,'wlan','<bg color="red"/><span font_desc="sans bold 9" color="white">${essid}</span>')

lqbarwidget = widget({ type = 'progressbar', name = 'lqbarwidget', align = 'right' })

lqbarwidget.width = 40
lqbarwidget.height = 0.80
lqbarwidget.gap = 0
lqbarwidget.border_padding = 1
lqbarwidget.border_width = 1
lqbarwidget.ticks_count = 5
lqbarwidget.ticks_gap = 1
lqbarwidget.vertical = false

lqbarwidget:bar_properties_set('lq', {
bg = 'gray20',
fg = 'green',
fg_off = 'gray20',
reverse = false,
min_value = 0,
max_value = 100
})

wicked.register(lqbarwidget, 'wlan', '${lq}', 1, 'lq')


ratewidget = widget({ type = 'textbox', name = 'ratewidget',align = 'right' })
wicked.register(ratewidget, 'wlan', ' <span color="green"> ${rate}</span> mb/s')



--}}}
--{{{Date
  datew = widget({type = 'textbox',name = 'datew',align = "right"  })
  wicked.register(datew, 'date','<bg color="gray20"/> <span font_desc="sans bold 9" color="white">%a %d %b - %H:%M</span>')
  datew:mouse_add(mouse({ }, 1, function () awful.spawn("wallswitch 1")end))
  datew:mouse_add(mouse({ }, 2, function () awful.spawn("wallswitch 2") end))
--}}}
-- {{{Create a tasklist widget
mytasklist = widget({ type = "tasklist", name = "mytasklist" })
mytasklist:mouse_add(mouse({ }, 1, function (object, c) client.focus = c; c:raise() end))
mytasklist:mouse_add(mouse({ }, 4, function () awful.client.focusbyidx(1) end))
mytasklist:mouse_add(mouse({ }, 5, function () awful.client.focusbyidx(-1) end))
mytasklist.label = awful.widget.tasklist.label.currenttags
--}}}
-- {{{Create a textbox widget
mytextbox = widget({ type = "textbox", name = "mytextbox", align = "right" })
-- Set the default text in textbox
mytextbox.text = "<b><small> awesome " .. AWESOME_VERSION .. " </small></b>"
mypromptbox = widget({ type = "textbox", name = "mypromptbox", align = "left" })
--}}}
--{{{ Create an iconbox widget
myiconbox = widget({ type = "textbox", name = "myiconbox", align = "left" })
myiconbox.text = "<bg image=\"/usr/local/share/awesome/icons/awesome16.png\" resize=\"true\"/>"

-- Create a systray
mysystray = widget({ type = "systray", name = "mysystray", align = "right" })
--}}}
-- {{{Create an iconbox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
mylayoutbox = {}
for s = 1, screen.count() do
    mylayoutbox[s] = widget({ type = "textbox", name = "mylayoutbox", align = "right" })
    mylayoutbox[s]:mouse_add(mouse({ }, 1, function () awful.layout.inc(layouts, 1) end))
    mylayoutbox[s]:mouse_add(mouse({ }, 3, function () awful.layout.inc(layouts, -1) end))
    mylayoutbox[s]:mouse_add(mouse({ }, 4, function () awful.layout.inc(layouts, 1) end))
    mylayoutbox[s]:mouse_add(mouse({ }, 5, function () awful.layout.inc(layouts, -1) end))
    mylayoutbox[s].text = "<bg image=\"/usr/local/share/awesome/icons/layouts/tilew.png\" resize=\"true\"/>"
end
--}}}
-- {{{ Create a statusbar for each screen and add it
mystatusbar = {}
for s = 1, screen.count() do
    mystatusbar[s] = statusbar({ position = "top", name = "mystatusbar" .. s,
                                   fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the statusbar - order matters
    mystatusbar[s].widgets =
    {
        battarywidget,
        mytaglist,tb_space,volumewidget,tb_space,
        mytasklist,
        mypromptbox,
        tb_spacer,mhzwidget,tb_spacer,cpugraphwidget,tb_spacer,
        membarwidget,tb_spacer,
        essidwidget,tb_spacer,lqbarwidget,tb_spacer,ratewidget,
        datew,

        mylayoutbox[s],
        s == screen.count() and mysystray or nil
    }
    mystatusbar[s].screen = s
end
-- }}}
-- }}}

-- {{{ Mouse bindings
awesome.mouse_add(mouse({ }, 3, function () awful.spawn(terminal) end))
awesome.mouse_add(mouse({ }, 4, awful.tag.viewnext))
awesome.mouse_add(mouse({ }, 5, awful.tag.viewprev))
-- }}}

-- {{{ Key bindings

-- {{{Bind keyboard digits
-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
    keybinding({ modkey }, i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           awful.tag.viewonly(tags[screen][i])
                       end
                   end):add()
    keybinding({ modkey, "Control" }, i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           tags[screen][i].selected = not tags[screen][i].selected
                       end
                   end):add()
    keybinding({ modkey, "Shift" }, i,
                   function ()
                       local sel = client.focus
                       if sel then
                           if tags[sel.screen][i] then
                               awful.client.movetotag(tags[sel.screen][i])
                           end
                       end
                   end):add()
    keybinding({ modkey, "Control", "Shift" }, i,
                   function ()
                       local sel = client.focus
                       if sel then
                           if tags[sel.screen][i] then
                               awful.client.toggletag(tags[sel.screen][i])
                           end
                       end
                   end):add()
end

keybinding({ modkey }, "Left", awful.tag.viewprev):add()
keybinding({ modkey }, "Right", awful.tag.viewnext):add()
keybinding({ modkey }, "Escape", awful.tag.history.restore):add()
--}}}

--{{{ Standard program
keybinding({ modkey }, "Return", function () awful.spawn(terminal) end):add()

keybinding({ modkey, "Control" }, "r", awesome.restart):add()
keybinding({ modkey, "Shift" }, "q", awesome.quit):add()
-- }}}

--{{{ Fn keys 

keybinding( {none}, "XF86AudioMute", function () awful.spawn("amix -c 0 set Master toggle") end):add()
keybinding( {none}, "XF86AudioRaiseVolume", function () awful.spawn("amixer -c 0 set Master 2dB+") end):add()
keybinding( {none}, "XF86AudioLowerVolume", function () awful.spawn("amixer -c 0 set Master 2dB-") end):add()
keybinding( {none}, "XF86AudioPlay", function () awful.spawn("mpc toggle") end):add()
keybinding( {none}, "XF86AudioNext", function () awful.spawn("mpc next") end):add()
keybinding( {none}, "XF86AudioStop", function () awful.spawn("mpc stop ") end):add()
keybinding( {none}, "XF86AudioPrev", function () awful.spawn("mpc prev ") end):add()
keybinding( {none}, "XF86Sleep", function () awful.spawn("sudo pm-suspend --quirk-dpms-on --quirk-vbestate-restore --quirk-vbemode-restore") end):add()
keybinding( {none}, "XF86HomePage", function () awful.spawn("sudo cpufreq-set -g ondemand") end):add()
keybinding( {none}, "XF86Start", function () awful.spawn("sudo cpufreq-set -g powersave") end):add()
keybinding( {none}, "XF86WWW", function () awful.spawn("swiftfox") end):add()
keybinding( {none}, "XF86Mail", function () awful.spawn("urxvt -e mutt") end):add()
keybinding( {none}, "XF86Messenger", function () awful.spawn("9menusudo") end):add()
--}}}

-- {{{Client manipulation
keybinding({ modkey }, "F5", awful.client.maximize):add()
keybinding({ modkey }, "w", function () client.focus:kill() end):add()
keybinding({ modkey }, "Left", function () awful.client.focusbyidx(1); client.focus:raise() end):add()
keybinding({ modkey }, "Right", function () awful.client.focusbyidx(-1);  client.focus:raise() end):add()
keybinding({ modkey, "Shift" }, "Left", function () awful.client.swap(1) end):add()
keybinding({ modkey, "Shift" }, "Right", function () awful.client.swap(-1) end):add()
keybinding({ modkey, "Control" }, "Left", function () awful.screen.focus(1) end):add()
keybinding({ modkey, "Control" }, "Right", function () awful.screen.focus(-1) end):add()
keybinding({ modkey, "Control" }, "space", awful.client.togglefloating):add()
keybinding({ modkey, "Control" }, "Return", function () client.focus:swap(awful.client.master()) end):add()
keybinding({ modkey }, "o", awful.client.movetoscreen):add()
keybinding({ modkey }, "Tab", awful.client.focus.history.previous):add()
-- }}}

--{{{ Layout manipulation
keybinding({ modkey }, "Down", function () awful.tag.incmwfact(0.05) end):add()
keybinding({ modkey }, "Up", function () awful.tag.incmwfact(-0.05) end):add()
keybinding({ modkey, "Shift" }, "Up", function () awful.tag.incnmaster(1) end):add()
keybinding({ modkey, "Shift" }, "Down", function () awful.tag.incnmaster(-1) end):add()
keybinding({ modkey, "Control" }, "Up", function () awful.tag.incncol(1) end):add()
keybinding({ modkey, "Control" }, "Down", function () awful.tag.incncol(-1) end):add()
keybinding({ modkey }, "space", function () awful.layout.inc(layouts, 1) end):add()
keybinding({ modkey, "Shift" }, "space", function () awful.layout.inc(layouts, -1) end):add()
-- }}}

--{{{ Prompt
keybinding({ modkey }, "F1", function ()
                                 awful.prompt.run({ prompt = "Run: " }, mypromptbox, awful.spawn, awful.completion.bash)
                             end):add()
keybinding({ modkey }, "F4", function ()
                                 awful.prompt.run({ prompt = "Run Lua code: " }, mypromptbox, awful.eval)
                             end):add()
keybinding({ modkey, "Ctrl" }, "i", function ()
                                        if mypromptbox.text then
                                            mypromptbox.text = nil
                                        else
                                            mypromptbox.text = "Class: " .. client.focus.class .. " Instance: ".. client.focus.instance
                                        end
                                    end):add()
-- }}}

--{{{ Tabulous, tab manipulation
keybinding({ modkey, "Control" }, "y", function ()
    local tabbedview = tabulous.tabindex_get()
    local nextclient = awful.client.next(1)

    if not tabbedview then
        tabbedview = tabulous.tabindex_get(nextclient)

        if not tabbedview then
            tabbedview = tabulous.tab_create()
            tabulous.tab(tabbedview, nextclient)
        else
            tabulous.tab(tabbedview, client.focus)
        end
    else
        tabulous.tab(tabbedview, nextclient)
    end
end):add()

keybinding({ modkey, "Shift" }, "y", tabulous.untab):add()

keybinding({ modkey }, "y", function ()
   local tabbedview = tabulous.tabindex_get()

   if tabbedview then
       local n = tabulous.next(tabbedview)
       tabulous.display(tabbedview, n)
   end
end):add()
-- }}}

--{{{ Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
keybinding({ modkey }, "t", awful.client.togglemarked):add()
keybinding({ modkey, 'Shift' }, "t", function ()
    local tabbedview = tabulous.tabindex_get()
    local clients = awful.client.getmarked()

    if not tabbedview then
        tabbedview = tabulous.tab_create(clients[1])
        table.remove(clients, 1)
    end

    for k,c in pairs(clients) do
        tabulous.tab(tabbedview, c)
    end

end):add()

for i = 1, keynumber do
    keybinding({ modkey, "Shift" }, "F" .. i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           for k, c in pairs(awful.client.getmarked()) do
                               awful.client.movetotag(tags[screen][i], c)
                           end
                       end
                   end):add()
end
-- }}}
-- }}}

-- {{{ Hooks
--
-- {{{stolen from wicked.lua
function splitbywhitespace(str) 
     values = {}
     start = 1
     splitstart, splitend = string.find(str, ' ', start)

     while splitstart do
            m = string.sub(str, start, splitstart-1)
            if m:gsub(' ','') ~= '' then
                 table.insert(values, m)
            end

            start = splitend+1
            splitstart, splitend = string.find(str, ' ', start)
     end

     m = string.sub(str, start)
     if m:gsub(' ','') ~= '' then
            table.insert(values, m)
     end

     return values
end
--}}}

--{{{ Hook function to execute when focusing a client.
function hook_focus(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end

-- Hook function to execute when unfocusing a client.
function hook_unfocus(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end

-- Hook function to execute when marking a client
function hook_marked(c)
    c.border_color = beautiful.border_marked
end

-- Hook function to execute when unmarking a client
function hook_unmarked(c)
    c.border_color = beautiful.border_focus
end

-- Hook function to execute when the mouse is over a client.
function hook_mouseover(c)
    -- Sloppy focus, but disabled for magnifier layout
    if awful.layout.get(c.screen) ~= "magnifier" then
        client.focus = c
    end
end
-- }}}

--{{{ Hook function to execute when a new client appears.
function hook_manage(c)
    -- Set floating placement to be smart!
    c.floating_placement = "smart"
    if use_titlebar then
        -- Add a titlebar
        awful.titlebar.add(c, { modkey = modkey })
    end
    -- Add mouse bindings
    c:mouse_add(mouse({ }, 1, function (c) client.focus = c; c:raise() end))
    c:mouse_add(mouse({ modkey }, 1, function (c) c:mouse_move() end))
    c:mouse_add(mouse({ modkey }, 3, function (c) c:mouse_resize() end))
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal
    client.focus = c

    -- Check if the application should be floating.
    local cls = c.class
    local inst = c.instance
    if floatapps[cls] then
        c.floating = floatapps[cls]
    elseif floatapps[inst] then
        c.floating = floatapps[inst]
    end

    -- Check application->screen/tag mappings.
    local target
    if apptags[cls] then
        target = apptags[cls]
    elseif apptags[inst] then
        target = apptags[inst]
    end
    if target then
        c.screen = target.screen
        awful.client.movetotag(tags[target.screen][target.tag], c)
    end

    -- Honor size hints
    c.honorsizehints = true
end
-- }}}

--{{{ Hook function to execute when arranging the screen
-- (tag switch, new client, etc)
function hook_arrange(screen)
    local layout = awful.layout.get(screen)
    if layout then
        mylayoutbox[screen].text =
            "<bg image=\"/usr/local/share/awesome/icons/layouts/" .. awful.layout.get(screen) .. "w.png\" resize=\"true\"/>"
        else
            mylayoutbox[screen].text = "No layout."
    end

    -- If no window has focus, give focus to the latest in history
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end

    -- Uncomment if you want mouse warping
    
    local sel = client.focus
    if sel then
        local c_c = sel.coords
        local m_c = mouse.coords

        if m_c.x < c_c.x or m_c.x >= c_c.x + c_c.width or
            m_c.y < c_c.y or m_c.y >= c_c.y + c_c.height then
            if table.maxn(m_c.buttons) == 0 then
                mouse.coords = { x = c_c.x + 5, y = c_c.y + 5}
            end
        end
    end
end
-- }}}

--{{{ Hook called every second
function hook_timer ()
    -- For unix time_t lovers
    mytextbox.text = " " .. os.time() .. " time_t "
    -- Otherwise use:
    -- mytextbox.text = " " .. os.date() .. " "
end
-- }}}

--{{{ Set up some hooks
awful.hooks.focus.register(hook_focus)
awful.hooks.unfocus.register(hook_unfocus)
awful.hooks.marked.register(hook_marked)
awful.hooks.unmarked.register(hook_unmarked)
awful.hooks.manage.register(hook_manage)
awful.hooks.mouseover.register(hook_mouseover)
awful.hooks.arrange.register(hook_arrange)
--awful.hooks.timer.register(1, hook_timer)
-- }}}
-- }}}

-- vim: set filetype=lua fdm=marker tabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent nu:
