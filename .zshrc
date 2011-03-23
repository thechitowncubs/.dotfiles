source ~/.bashrc
autoload -U compinit promptinit
compinit
promptinit
# This will set the default prompt to the walters theme
prompt walters

#History
HISTFILE=~/.zshhistory
HISTSIZE=1024
SAVEHIST=1024

if [[ -z "$DISPLAY" && "$(tty)" = /dev/tty1 ]]; then
    exec startx
fi
