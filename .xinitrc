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
status.sh &
setxkbmap us -option compose:ralt -option compose:caps
dcompmgr &
exec wmfs
#exec ck-launch-session startkde
#exec ck-launch-session gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
