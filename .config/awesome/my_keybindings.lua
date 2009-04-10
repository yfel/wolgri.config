--{{{ Base keybindings 
table.insert(globalkeys, key({ modkey }, "F5", function () client.focus.fullscreen = not client.focus.fullscreen end))
table.insert(clientkeys, key({ modkey }, "w", function (c) c:kill() end))
table.insert(globalkeys, key({ modkey }, "Left", function () awful.client.focus.byidx(1); if client.focus then client.focus:raise() end end))
table.insert(globalkeys, key({ modkey }, "Right", function () awful.client.focus.byidx(-1);  if client.focus then client.focus:raise() end end))
table.insert(globalkeys, key({ modkey, "Shift" }, "Left", function () awful.client.swap.byidx(1) end))
table.insert(globalkeys, key({ modkey, "Shift" }, "Right", function () awful.client.swap.byidx(-1) end))
table.insert(globalkeys, key({ modkey, "Control" }, "Left", function () awful.screen.focus(1) end))
table.insert(globalkeys, key({ modkey, "Control" }, "Right", function () awful.screen.focus(-1) end))
table.insert(globalkeys, key({ modkey }, "Up", function () awful.tag.incmwfact(0.05) end))
table.insert(globalkeys, key({ modkey }, "Down", function () awful.tag.incmwfact(-0.05) end))
table.insert(globalkeys, key({ modkey, "Shift" }, "Down", function () awful.tag.incnmaster(1) end))
table.insert(globalkeys, key({ modkey, "Shift" }, "Up", function () awful.tag.incnmaster(-1) end))
table.insert(globalkeys, key({ modkey, "Control" }, "Down", function () awful.tag.incncol(1) end))
table.insert(globalkeys, key({ modkey, "Control" }, "Up", function () awful.tag.incncol(-1) end))
table.insert(globalkeys, key({"Control"}, "Escape", function () awful.util.spawn(screensaver) end))
table.insert(globalkeys, key({ modkey, "Shift" }, "Left", function () awful.client.focus.byidx(1); client.focus:lower() end))
table.insert(globalkeys, key({ modkey, "Shift" }, "Right", function () awful.client.focus.byidx(1); client.focus:raise() end))
table.insert(clientkeys, key({ modkey, "Shift" }, "t", function (c) if c.titlebar then awful.titlebar.remove(c) else awful.titlebar.add(c, { modkey = "Mod1" }) end end))
--}}}
--{{{ Move resize 
table.insert(globalkeys, key({ modkey, "Control" }, "Up", function () awful.client.moveresize(0, 0, 0, -10) end))
table.insert(globalkeys, key({ modkey, "Control" }, "Right", function () awful.client.moveresize(0, 0, 10, 0) end))
table.insert(globalkeys, key({ modkey, "Control" }, "Down", function () awful.client.moveresize(0, 0, 0, 10) end))
table.insert(globalkeys, key({ modkey, "Control" }, "Left", function () awful.client.moveresize(0, 0, -10, 0) end))
----
table.insert(globalkeys, key({ modkey, "Mod1" }, "Up", function () awful.client.moveresize(0, -10, 0, 0) end))
table.insert(globalkeys, key({ modkey, "Mod1" }, "Right", function () awful.client.moveresize(10, 0, 0, 0) end))
table.insert(globalkeys, key({ modkey, "Mod1" }, "Down", function () awful.client.moveresize(0, 10, 0, 0) end))
table.insert(globalkeys, key({ modkey, "Mod1" }, "Left", function () awful.client.moveresize(-10, 0, 0, 0) end))
--}}}
--{{{ Fn keys  
table.insert(globalkeys, key({ }, "XF86AudioRaiseVolume", function () volume("up", pb_volume) end))
table.insert(globalkeys, key({ }, "XF86AudioLowerVolume", function () volume("down", pb_volume) end))
table.insert(globalkeys, key({ }, "XF86AudioMute", function () volume("mute", pb_volume) end))
table.insert(globalkeys, key({none}, "XF86AudioPlay", function () awful.util.spawn("mpc --no-status toggle") end))
table.insert(globalkeys, key({none}, "XF86AudioNext", function () awful.util.spawn("mpc --no-status next") end))
table.insert(globalkeys, key({none}, "XF86AudioStop", function () awful.util.spawn("mpc --no-status stop ") end))
table.insert(globalkeys, key({none}, "XF86AudioPrev", function () awful.util.spawn("mpc --no-status prev ") end))
table.insert(globalkeys, key({none}, "XF86Sleep", function () awful.util.spawn("sudo pm-suspend --quirk-dpms-on --quirk-vbestate-restore --quirk-vbemode-restore") end))
table.insert(globalkeys, key({none}, "XF86HomePage", function () awful.util.spawn("sudo cpufreq-set -g ondemand") end))
table.insert(globalkeys, key({none}, "XF86Start", function () awful.util.spawn("sudo cpufreq-set -g powersave") end))
table.insert(globalkeys, key({none}, "XF86WWW", function () awful.util.spawn("swiftfox") end))
table.insert(globalkeys, key({none}, "XF86Mail", function () awful.util.spawn("urxvt -e mutt") end))
table.insert(globalkeys, key({none}, "XF86Messenger", function () mymainmenu:toggle() end))
--}}}
--{{{ rotate clients and focus master...
table.insert(globalkeys, key({ modkey }, "Tab", function ()
    local allclients = awful.client.visible(client.focus.screen)
  
    for i,v in ipairs(allclients) do
      if allclients[i+1] then
        allclients[i+1]:swap(v)
      end
    end
    awful.client.focus.byidx(-1)
  end))

-- ... the other way 'round!
table.insert(globalkeys, key({ modkey, "Shift" }, "Tab", function ()
    local allclients = awful.client.visible(client.focus.screen)
    local toswap

    for i,v in ipairs(allclients) do
      if toswap then
        toswap:swap(v)
        toswap = v
      else
        toswap = v
      end
    end
    awful.client.focus.byidx(-1)
  end))
--}}}
-- Show some client infos in a naughy box--{{{
-- Collect client infos
function get_fixed_client_infos(c)
    local txt = ""
    if c.name then txt = txt .."Name:".. c.name .. "\n" end
    if c.pid then txt = txt .."PID:".. c.pid .. "\n" end
    if c.class then txt = txt .."Class:".. c.class .. "\n" end
    if c.instance then txt = txt .."Instance:".. c.instance .. "\n" end
    if c.role then txt = txt .."Role:".. c.role .. "\n" end
    if c.type then txt = txt .."Type:".. c.type .. "\n" end
    return txt
end

function get_dyn_client_infos(c)
    local txt = ""
    if c.screen then txt = txt .."Screen: ".. c.screen .. "\n" end
    if awful.client.floating.get(c) then txt = txt .."Floating\n" end
    if c.ontop then txt = txt .."On top\n" end
    if c.fullscreen then txt = txt .."Fullscreen\n" end
    if c.titlebar then txt = txt .."Titlebar\n" end
    if c.opacity then txt = txt .. "Opacity: " .. c.opacity .. "\n" end
    if c.icon_path then txt = txt .."Icon_path: ".. c.icon_path .. "\n" end
    return txt
end


function show_client_infos(c)
    local c
    if _c then
        c = _c
    else
        c = client.focus
    end
    txt = get_fixed_client_infos(c)
    txt = txt .. "\n" .. get_dyn_client_infos(c)
    naughty.notify({ title = "Client info", text = txt, timeout = 6 })
end
table.insert(globalkeys, key({ modkey, "Control" }, "i", show_client_infos))

--}}}

root.keys(globalkeys)
