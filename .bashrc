
# Check for an interactive session
[ -z "$PS1" ] && return

#Set package manager
PACMAN="clyde"

#Exports
export BROWSER="chromium"
export PATH="$HOME/bin:$PATH"

#Aliases
alias ls="ls --color"
alias systemupdate='sudo clyde -Syyu'
alias svim='sudo vim'
alias serv='ssh john@server'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"

#Clyde Aliases
alias install="sudo $PACMAN -S --noconfirm"
alias uninstall="sudo pacman -R"
alias sysupdate="sudo $PACMAN -Syyua --noconfirm"

export BROWSER="chromium"
export PATH="$HOME/bin:$PATH"

#Functions
Size() {
    du -h "$@" \
    | sort -h  \
    | tac      \
    | less
}

if [[ -z "$DISPLAY" && "$(tty)" = /dev/tty1 ]]; then
    exec startx
fi
