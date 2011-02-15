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
{ sleep 5; ~/.config/wmfs/wmfs-bars.sh; } &
exec wmfs
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
