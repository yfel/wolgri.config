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



--}}}
--{{{ Move resize 
--table.insert(globalkeys, key({ modkey, "Control" }, "Up", function () awful.client.moveresize(0, 0, 0, -10) end))
--table.insert(globalkeys, key({ modkey, "Control" }, "Right", function () awful.client.moveresize(0, 0, 10, 0) end))
--table.insert(globalkeys, key({ modkey, "Control" }, "Down", function () awful.client.moveresize(0, 0, 0, 10) end))
--table.insert(globalkeys, key({ modkey, "Control" }, "Left", function () awful.client.moveresize(0, 0, -10, 0) end))
----
--table.insert(globalkeys, key({ modkey, "Mod1" }, "Up", function () awful.client.moveresize(0, -10, 0, 0) end))
--table.insert(globalkeys, key({ modkey, "Mod1" }, "Right", function () awful.client.moveresize(10, 0, 0, 0) end))
--table.insert(globalkeys, key({ modkey, "Mod1" }, "Down", function () awful.client.moveresize(0, 10, 0, 0) end))
--table.insert(globalkeys, key({ modkey, "Mod1" }, "Left", function () awful.client.moveresize(-10, 0, 0, 0) end))
--}}}
--{{{ Fn keys  
table.insert(globalkeys, key({none}, "XF86AudioMute", function () awful.util.spawn("amixer -c 0 set Master toggle") end))
table.insert(globalkeys, key({none}, "XF86AudioRaiseVolume", function () awful.util.spawn("amixset +") end))
table.insert(globalkeys, key({none}, "XF86AudioLowerVolume", function () awful.util.spawn("amixset -") end))
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
--{{{ My widgets
--{{{ Spacer
local bg_color = beautiful.bg_normal
tb_space= widget({ type = 'textbox', name = 'tb_space'})
tb_space.width = "4"
tb_space.text = " "

tb_spacer= widget({ type = 'textbox', name = 'tb_spacer',align = 'right' })
tb_spacer.width = "6"
tb_spacer.text = tb_space.text

--}}}
--{{{ Batt
battarywidget = widget({ type = 'progressbar', name = 'battarywidget' })
battarywidget.width = 100
battarywidget.height = 0.8
battarywidget.gap = 1
battarywidget.border_padding = 1
battarywidget.border_width = 1
battarywidget.ticks_count = 10
battarywidget.ticks_gap = 1
battarywidget.vertical = false
battarywidget:bar_properties_set('bat', {
bg = beautiful.fg_urgent,
fg = beautiful.bg_focus,
fg_off = 'red',
reverse = false,
min_value = 0,
max_value = 100
})

--}}}
--{{{ skb
skbwidget = widget({ type = 'textbox', name = 'skbwidget' , align = 'left' })
--}}}
--{{{ temp
tempwidget = widget({ type = 'textbox', name = 'cfreqwidget' , align = 'right' })
--}}}
--{{{ Mhz
cfreqwidget = widget({ type = 'textbox', name = 'cfreqwidget' , align = 'right' })
--}}}
--{{{ Cpu

cpu0graphwidget = widget({ type = 'graph', name = 'cpu0graphwidget', align = 'right' }) 
cpu0graphwidget.height = 1
cpu0graphwidget.width = 100
cpu0graphwidget.bg = beautiful.bg_normal
cpu0graphwidget.border_color = beautiful.fg_urgent
cpu0graphwidget.grow = 'left'

cpu0graphwidget:plot_properties_set('cpu', { 
fg = beautiful.bg_urgent,
style ='line',
--fg_center = 'green', 
--fg_end = 'cyan', 
vertical_gradient = false 
})
cpu1graphwidget = widget({ type = 'graph', name = 'cpu1graphwidget', align = 'right' }) 
cpu1graphwidget.height = 1
cpu1graphwidget.width = 100
cpu1graphwidget.bg = beautiful.bg_normal
cpu1graphwidget.border_color = beautiful.fg_urgent
cpu1graphwidget.grow = 'left'

cpu1graphwidget:plot_properties_set('cpu', { 
fg = beautiful.bg_urgent,
style ='line',
--fg_center = 'green', 
--fg_end = 'cyan', 
vertical_gradient = false 
})
--}}}
--{{{MeM 
memwidget = widget({ type = 'graph', name = 'memwidget', align = 'right' })

memwidget.width = 80
memwidget.height = 1
memwidget.gap = 0
memwidget.border_padding = 0
memwidget.border_width = 0
--memwidget.ticks_count = 0
--memwidget.ticks_gap = 0
memwidget.vertical = false
memwidget.grow = "left"
memwidget:plot_properties_set('mem', { 
fg = beautiful.fg_urgent,
--style ='line',
vertical_gradient = false 
})

--}}}
--{{{ Wifi
essidwidget = widget({ type = 'textbox', name = 'essidwidget',align = 'right' })

lqbarwidget = widget({ type = 'progressbar', name = 'lqbarwidget', align = 'right' })

lqbarwidget.width = 70
lqbarwidget.height = 1
lqbarwidget.gap = 0
lqbarwidget.border_padding = 1
lqbarwidget.border_width = 1
lqbarwidget.ticks_count = 10
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
ratewidget = widget({ type = 'textbox', name = 'ratewidget',align = 'right' })



--}}}
--{{{Date
  datew = widget({type = 'textbox',name = 'datew',align = "right"  })
--}}}
--}}}
-- {{{ Bottom panel
-- Create a botbox for each screen and add it
botbox = {}
botbox[1] = wibox({ position = "bottom", name = "botbox" .. 1 , height = "18", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
-- Add widgets to the wibox - order matters
botbox[1].widgets = {
--     skbwidget,
     battarywidget,
     tempwidget,tb_spacer,
     cfreqwidget,tb_spacer,
     cpu0graphwidget,tb_spacer,
     cpu1graphwidget,tb_spacer,
     memwidget,tb_spacer,
--     essidwidget,tb_spacer, lqbarwidget,tb_spacer, ratewidget, tb_spacer,
     datew,mysystray
        }
botbox[1].screen = 1

--}}}
--  {{{ My hooks
--{{{ cpu
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
            
            cpu0graphwidget:plot_data_add("cpu",usage_percent)
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

            cpu1graphwidget:plot_data_add("cpu",usage_percent)
        
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
 memwidget:plot_data_add("mem",mem_percent)
end
--}}}
--{{{ cfreq hook
function get_cfreq()
    local m = io.popen("cpufreq-info -p | awk '{print $3 }'")
      for line in m:lines() do
            cfreq = line
      end    

    m:close()
cfreqwidget.text =""..cfreq..""
end 
--}}} 
--{{{ temp hook
function get_temp()
    local m = io.popen("echo \"scale=0 ;`cat /sys/bus/pci/drivers/k8temp/*/temp1_input`/1000 \"| bc -l")
      for line in m:lines() do
            temp = line
      end    

    m:close()
tempwidget.text =""..temp.."°"
end 
--}}} 
--{{{ skb hook
function get_skb()
    local m = io.popen("skb -1")
      for line in m:lines() do
            skb = line
      end    

    m:close()
skbwidget.text ="<bg color=\"blue\"/><span font_desc=\"sans bold 9\" color=\"white\"> " ..skb.. " </span>"
end 
--}}} 
--{{{ wifi hook

local function get_iwinfo_iwcfg()
    local wlann="ath0"
	local f1 = io.popen("/sbin/iwconfig " .. wlann)
	if not f1 then
		return
	else
		local iwOut = f1:read('*a')
		f1:close()
		st,en,proto = string.find(iwOut, '(802.11[%-]*%a*)')
		st,en,ssid = string.find(iwOut, 'ESSID[=:]"([%w+%s*]*)"', en)
		st,en,bitrate = string.find(iwOut, 'Bit Rate[=:]([%s%w%.]*%/%a+)', en)
		bitrate = string.gsub(bitrate, "%s", "")
		st,en,linkq1,linkq2 = string.find(iwOut, 'Link Quality[=:](%d+)/(%d+)', en)
		st,en,signal = string.find(iwOut, 'Signal level[=:](%-%d+)', en)
		st,en,noise = string.find(iwOut, 'Noise level[=:](%-%d+)', en)
        linkq = math.floor(100*linkq1/linkq2)
		return proto, ssid, bitrate, linkq, signal, noise
	end
end

local function update_iwinfo()
	local proto, ssid, bitrate, linkq, signal, noise = get_iwinfo_iwcfg()

-- In case get_iwinfo_iwcfg doesn't return any values we don't want stupid lua
-- errors about concatenating nil values.
	ssid = ssid or "N/A"
	bitrate = bitrate or "N/A"
	linkq = linkq or "N/A"
	signal = signal or "N/A"
	noise = noise or "N/A"
	proto = proto or "N/A"

essidwidget.text ="<bg color=\"red\"/><span font_desc=\"sans bold 9\" color=\"white\"> "..ssid.." </span>"
ratewidget.text = "<span color=\"green\">"..bitrate.."</span>"
lqbarwidget:bar_data_add("lq",linkq )


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
battarywidget:bar_data_add("bat",batt )

end

--}}}
--{{{ date hook 
function hook_timer ()
    os.setlocale(os.getenv("LC_ALL"))
    datew.text ="<span font_desc=\"sans bold 8\" color=\"white\">"..os.date('%a %d %b  %H:%M').."</span>"
end
-- }}}
-- {{{ splitbywhitespace stolen from wicked.lua
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
--{ {{ Set My some hooks

function onesec()
    hook_timer()
    get_mem()
    get_cpu()
    get_cfreq()
--    get_skb()
end

function fivesec()
--    update_iwinfo()
    get_bat()
    get_temp()

end

awful.hooks.timer.register(1, onesec)
awful.hooks.timer.register(5, fivesec)
--}}}
--{{{ Naughty Callendar 
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
        })
    end

    datew.mouse_enter = function()
        add_calendar(0)
    end
    datew.mouse_leave = remove_calendar

    datew:buttons({
        button({ }, 4, function()
            add_calendar(-1)
        end),
        button({ }, 5, function()
            add_calendar(1)
        end),
    })
--}}}
-- vim: set filetype=lua fdm=marker tabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent nu:
