
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export BROWSER="chromium"

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
    exec startx
fi
