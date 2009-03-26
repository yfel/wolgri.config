export PATH=$PATH:$HOME/bin:$HOME/scripts
export DISPLAY=":0"
export LANG=uk_UA.UTF-8
export LC_ALL=uk_UA.UTF-8
export GTK_MODULES=winmenu 
xset fp+ /home/wolgri/.fonts/ 
xset fp rehash
xrdb $HOME/.Xdefaults
xmodmap $HOME/.Xmodmap
awesome 2>> $HOME/awesome.err&
exec bash $HOME/.autostart
