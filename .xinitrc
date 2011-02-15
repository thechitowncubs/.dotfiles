#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#DWM Clock
#while true; do
#   xsetroot -name "$( date +"%A, %F %r" )"
#   sleep 1m    # Update time every minute
#done &
xbindkeys &
/usr/bin/xscreensaver -no-splash &
exec wmfs
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
