source ~/.bashrc
autoload -U compinit promptinit
compinit
promptinit
# This will set the default prompt to the walters theme
prompt walters

#Exports
export BROWSER="chromium"
export PATH="$HOME/bin:$PATH"

#Aliases
alias ls="ls --color"
alias systemupdate='sudo clyde -Syyu'
alias svim='sudo vim'
alias serv='ssh john@server'

if [[ -z "$DISPLAY" && "$(tty)" = /dev/tty1 ]]; then
    exec startx
fi
