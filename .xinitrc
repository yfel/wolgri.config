export PATH=$PATH:$HOME/bin:$HOME/scripts
export DISPLAY=":0"
export LANG=uk_UA.UTF-8
export LC_ALL=uk_UA.UTF-8
export GTK_MODULES=winmenu 
export OOO_FORCE_DESKTOP="gnome"
export MOZ_DISABLE_PANGO=1

#export LC_CTYPE="en_US.utf8"
#export XMODIFIERS=@im=SCIM
#export GTK_IM_MODULE="scim"
#export QT_IM_MODULE="scim-bridge"
#scim -d

xset fp+ /home/wolgri/.fonts/ 
xset fp rehash
xrdb $HOME/.Xdefaults
xmodmap $HOME/.Xmodmap

unclutter -root -idle 5 &

xsetroot -solid '#222222'

autocutsel -s PRIMARY -buttonup -fork

# XKB
#setxkbmap -option grp:caps_toggle,lv3:ralt_switch,grp_led:scroll 'us,ua,ru'

#Synaptic
syndaemon -d 
synclient HorizTwoFingerScroll=0
synclient VertTwoFingerScroll=0
synclient HorizEdgeScroll=0
synclient VertEdgeScroll=0
synclient CircularScrolling=0
ivman &
awesome 2> $HOME/awesome.err&
lilyterm -t 2 -e screen -ddR grw & 
nitrogen --restore
## VNC session 
#x11vnc -usepw -shared -forever > /dev/null &
wicd-client&
wwwfox&
xxkb&
exec xscreensaver
