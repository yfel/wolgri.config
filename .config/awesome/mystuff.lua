--{{{ Base keybindings 
--keybinding({ modkey }, "F2", revelation.revelation):add()
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
table.insert(globalkeys, key({"Control"}, "Escape", function () awful.util.spawn(xlock) end))
table.insert(globalkeys, key({ modkey, "Shift" }, "Left", function () awful.client.focus.byidx(1); client.focus:lower() end))
table.insert(globalkeys, key({ modkey, "Shift" }, "Right", function () awful.client.focus.byidx(1); client.focus:raise() end))
table.insert(globalkeys, key({ modkey }, "F3", function () awful.util.spawn("mocp -G") end))
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
table.insert(globalkeys, key({none}, "XF86AudioPlay", function () awful.util.spawn("mpc toggle") end))
table.insert(globalkeys, key({none}, "XF86AudioNext", function () awful.util.spawn("mpc next") end))
table.insert(globalkeys, key({none}, "XF86AudioStop", function () awful.util.spawn("mpc stop ") end))
table.insert(globalkeys, key({none}, "XF86AudioPrev", function () awful.util.spawn("mpc prev ") end))
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
root.keys(globalkeys)
--{{{Widgets
--{{{ Spacer
local bg_color = beautiful.bg_normal
tb_space= widget({ type = 'textbox', name = 'tb_space'})
tb_space.width = "4"
tb_space.text = ""

tb_spacer= widget({ type = 'textbox', name = 'tb_spacer',align = 'right' })
tb_spacer.width = "6"
tb_spacer.text = tb_space.text

--}}}
--{{{ Batt
pb_bat = widget({ type = 'progressbar', name = 'pb_bat' })
pb_bat.width = 60
pb_bat.height = 0.6
pb_bat.gap = 1
pb_bat.border_padding = 0
pb_bat.border_width = 1
pb_bat.ticks_count = 10
pb_bat.ticks_gap = 1
pb_bat.vertical = false
pb_bat:bar_properties_set('bat', {

bg = beautiful.fg_urgent,
fg = beautiful.bat_fg,
fg_off = beautiful.color_red,
reverse = false,
min_value = 0,
max_value = 100
})

--}}}
--{{{ temp
tb_temp = widget({ type = 'textbox', name = 'tb_fq' , align = 'right' })
--}}}
--{{{ FQ
tb_fq = widget({ type = 'textbox', name = 'tb_fq' , align = 'left'})
--}}}
--{{{ Cpu

gr_cpu0 = widget({ type = 'graph', name = 'gr_cpu0', align = 'left' }) 
gr_cpu0.height = 0.8
gr_cpu0.width = 60
gr_cpu0.bg = beautiful.bg_focus
gr_cpu0.border_color = beautiful.fg_urgent
gr_cpu0.grow = 'left'

gr_cpu0:plot_properties_set('cpu', { 
style ='line',
fg = beautiful.border_marked,
fg_center = beautiful.color_green, 
fg_end = beautiful.color_cyan, 
vertical_gradient = true 
})
gr_cpu1 = widget({ type = 'graph', name = 'gr_cpu1', align = 'left' }) 
gr_cpu1.height = 0.8
gr_cpu1.width = 60
gr_cpu1.bg = beautiful.bg_focus
gr_cpu1.border_color = beautiful.fg_urgent
gr_cpu1.grow = 'left'

gr_cpu1:plot_properties_set('cpu', { 
style ="line",
fg = beautiful.border_marked,
fg_center = beautiful.color_green, 
fg_end = beautiful.color_cyan, 
vertical_gradient = true 
})
--}}}
--{{{MeM 
pb_mem = widget({ type = 'progressbar', name = 'pb_mem', align = 'left' })

pb_mem.width = 40
pb_mem.height = 0.8
pb_mem.gap = 1
pb_mem.border_padding = 0
pb_mem.border_width = 1
pb_mem.ticks_count = 10
pb_mem.ticks_gap = 1
pb_mem.vertical = false
pb_mem.grow = "left"
pb_mem:bar_properties_set('mem',
{
    ["bg"] = beautiful.fg_urgent ,
    ["fg_off"] = beautiful.bg_focus ,
    ["fg"] = beautiful.color_green ,
    ["reverse"] = false,
    ["min_value"] = 0,
    ["max_value"] = 100
})

--}}}
--{{{Date
  tb_date = widget({type = 'textbox',name = 'tb_date',align = "right"  })
--}}}
--{{{ Volume
 pb_volume =  widget({ type = "progressbar", name = "pb_volume", align = "right" })
 pb_volume.width = 40
 pb_volume.height = 0.80
 pb_volume.border_padding = 1
 pb_volume.ticks_count = 10
 pb_volume.vertical = false
 
 pb_volume:bar_properties_set("vol", 
 { 
   ["bg"] = "#000000",
   ["fg"] = "#6666cc",
   ["fg_off"] = "#000000",
   ["border_color"] = "#999933"
 })
pb_volume:buttons({
     button({ }, 4, function () volume("up", pb_volume) end),
     button({ }, 5, function () volume("down", pb_volume) end),
     button({ }, 1, function () volume("mute", pb_volume) end)
 })

--}}}
--}}}
-- {{{Bottom panel
-- Create a botbox for each screen and add it
botbox = {}
botbox[1] = wibox({ position = "bottom", name = "botbox" .. 1 , height = "14", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
-- Add widgets to the wibox - order matters
botbox[1].widgets = {
--     skbwidget,
     tb_fq,tb_space,
     gr_cpu0,tb_space,
     gr_cpu1,tb_space,
     pb_mem,tb_space,
     pb_bat,
     tb_temp,tb_spacer,
        pb_volume,
--     essidwidget,tb_spacer, lqbarwidget,tb_spacer, ratewidget, tb_spacer,
     tb_date,mysystray
        }
botbox[1].screen = 1

--}}}
--{{{Hooks & functions 
--{{{cpu
cpu0_total = 0
cpu0_active = 0
cpu1_total = 0
cpu1_active = 0

function get_cpu()
    -- Return CPU usage percentage
    ---- Get /proc/stat
    local f = io.open('/proc/stat')
    for l in f:lines() do
    cpu_usage = splitbywhitespace(l)
    if cpu_usage[1] == "cpu0" then
            ---- Calculate totals
            total_new = cpu_usage[2]+cpu_usage[3]+cpu_usage[4]+cpu_usage[5]
            active_new = cpu_usage[2]+cpu_usage[3]+cpu_usage[4]
            
            ---- Calculate percentage
            diff_total = total_new-cpu0_total
            diff_active = active_new-cpu0_active
            usage_percent = math.floor(diff_active/diff_total*100)

            ---- Store totals
            cpu0_total = total_new
            cpu0_active = active_new
            
            gr_cpu0:plot_data_add("cpu",usage_percent)
     elseif cpu_usage[1] == "cpu1" then
            ---- Calculate totals
            total_new = cpu_usage[2]+cpu_usage[3]+cpu_usage[4]+cpu_usage[5]
            active_new = cpu_usage[2]+cpu_usage[3]+cpu_usage[4]
            
            ---- Calculate percentage
            diff_total = total_new-cpu1_total
            diff_active = active_new-cpu1_active
            usage_percent = math.floor(diff_active/diff_total*100)

            ---- Store totals
            cpu1_total = total_new
            cpu1_active = active_new

            gr_cpu1:plot_data_add("cpu",usage_percent)
        
    end

end
f:close()
end
--}}} 
--{{{ mem hook
function get_mem()
  local mem_free, mem_total, mem_c, mem_b
  local mem_percent, swap_percent, line, fh, count
  count = 0

  fh = io.open("/proc/meminfo")

  line = fh:read()
  while line and count < 4 do
    if line:match("MemFree:") then
      mem_free = string.match(line, "%d+")
      count = count + 1;
    elseif line:match("MemTotal:") then
      mem_total = string.match(line, "%d+")
      count = count + 1;
    elseif line:match("Cached:") then
      mem_c = string.match(line, "%d+")
      count = count + 1;
    elseif line:match("Buffers:") then
      mem_b = string.match(line, "%d+")
      count = count + 1;
    end
    line = fh:read()
  end
  io.close(fh)

  mem_percent = 100 * (mem_total - mem_free - mem_b - mem_c ) / mem_total;
 pb_mem:bar_data_add("mem",mem_percent)
end
--}}}
--{{{ cfreq hook
function get_cfreq()
    local m = io.popen("cpufreq-info -p | awk '{print $3 }'")
      for line in m:lines() do
            cfreq = line
      end    

    m:close()
tb_fq.text ="<span font_desc='sans bold 8'>"..cfreq.."</span>"
end 
--}}} 
--{{{ temp hook
function get_temp()
    local m = io.popen("echo \"scale=0 ;`cat /sys/bus/pci/drivers/k8temp/*/temp1_input`/1000 \"| bc -l")
      for line in m:lines() do
            temp = line
      end    

    m:close()
tb_temp.text =""..temp.."°"
end 
--}}} 
--{{{ batt hook
local function get_bat()
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

            if tonumber(batt) <= 10 
            then
                naughty.notify({ title      = "Battery Warning"
                               , text       = "Battery low! "..batt.."% left!"
                               , timeout    = 30
                               , position   = "top_right"
                               , fg         = beautiful.fg_focus
                               , bg         = beautiful.bg_focus
                               })
            end
            batt = batt

pb_bat:bar_data_add("bat",batt )
end

--}}}
--{{{ date hook 
function hook_timer ()
    os.setlocale(os.getenv("LC_ALL"))
    tb_date.text = os.date('%a %d %b  %H:%M')
end
-- }}}
--{{{splitbywhitespace stolen from wicked.lua
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
--{{{Battery (BAT0)
function batteryInfo(adapter)
    local fcur = io.open("/sys/class/power_supply/"..adapter.."/charge_now")    
    local fcap = io.open("/sys/class/power_supply/"..adapter.."/charge_full")
    local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")
    local cur = fcur:read()
    fcur:close()
    local cap = fcap:read()
    fcap:close()
    local sta = fsta:read()
    fsta:close()
    
    local battery = math.floor(cur * 100 / cap)
    
    if sta:match("Charging") then
        dir = "^"
        battery = "A/C ("..battery..")"
    elseif sta:match("Discharging") then
        dir = "v"
        if tonumber(battery) >= 25 and tonumber(battery) <= 50 then
            battery = setFg("#e6d51d", battery)
        elseif tonumber(battery) < 25 then
            if tonumber(battery) <= 10 then
                naughty.notify({ title      = "Battery Warning"
                               , text       = "Battery low! "..battery.."% left!"
                               , timeout    = 30
                               , position   = "top_right"
                               , fg         = beautiful.fg_focus
                               , bg         = beautiful.bg_focus
                               })
            end
            battery = setFg("#ff6565", battery)
        else
            battery = battery
        end
    else
        dir = "="
        battery = "A/C"
    end
    
    batterywidget.text = setFg(beautiful.fg_focus, "Battery: ")..dir..battery.."% "
end
-- }}}
--{{{Naughty Callendar
 local calendar = nil
    local offset = 0

    function remove_calendar()
        if calendar ~= nil then
            naughty.destroy(calendar)
            calendar = nil
            offset = 0
        end
    end

    function add_calendar(inc_offset)
        local save_offset = offset
        remove_calendar()
        offset = save_offset + inc_offset
        local datespec = os.date("*t")
        datespec = datespec.year * 12 + datespec.month - 1 + offset
        datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)
        local cal = awful.util.pread("cal -m " .. datespec)
        cal = string.gsub(cal, "^%s*(.-)%s*$", "%1")
        calendar = naughty.notify({
            text = os.date("%a, %d %B %Y") .. "\n" .. cal,
            timeout = 0, hover_timeout = 0.5,
            width = 160,
            position  = "bottom_right",
            fg ="black", bg = "gray70",

        })
    end

    tb_date.mouse_enter = function()
        add_calendar(0)
    end
    tb_date.mouse_leave = remove_calendar

    tb_date:buttons({
        button({ }, 4, function()
            add_calendar(-1)
        end),
        button({ }, 5, function()
            add_calendar(1)
        end),
    })
--}}}
--{{{ Volume 
cardid  = 0
channel = "Master"

 function volume (mode, widget)
    if mode == "update" then
        local status = io.popen("amixer -c " .. cardid .. " -- sget " .. channel):read("*all")
        
        local volume = string.match(status, "(%d?%d?%d)%%")
 
        status = string.match(status, "%[(o[^%]]*)%]")
 
        if string.find(status, "on", 1, true) then
            widget:bar_properties_set("vol", {["bg"] = "#000000"})
        else
            widget:bar_properties_set("vol", {["bg"] = "#cc3333"})
        end
        widget:bar_data_add("vol", volume)
    elseif mode == "up" then
        awful.util.spawn("amixer -q -c " .. cardid .. " sset " .. channel .. " 5%+")
        volume("update", widget)
    elseif mode == "down" then
        awful.util.spawn("amixer -q -c " .. cardid .. " sset " .. channel .. " 5%-")
        volume("update", widget)
    else
        awful.util.spawn("amixer -c " .. cardid .. " sset " .. channel .. " toggle")
        volume("update", widget)
    end
 end
volume("update", pb_volume);

--}}}
--{{{Timers
awful.hooks.timer.register(1, hook_timer)
awful.hooks.timer.register(1, get_mem)
awful.hooks.timer.register(1, get_cpu)
awful.hooks.timer.register(1, get_cfreq)
--awful.hooks.timer.register(1, get_skb)
--awful.hooks.timer.register(1, update_iwinfo)
awful.hooks.timer.register(3, get_bat)
awful.hooks.timer.register(3, get_temp)
--}}}
-- vim: set filetype=lua fdm=marker tabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent nu:
