#!/bin/sh
WLAN=ath0
/sbin/iwconfig $WLAN |sed -e 's/[:=\/\"]/ /g'|awk '
 /ESSID/ {print "ESSID: " $5} 
 /Bit Rate/ {print "Rate: " $3" "$4"/"$5}
 /Link Quality/ {print "Quality:" ($3/$4)*100}' 

