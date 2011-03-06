base:
	ln -sf ${PWD}/.ssh-config ${HOME}/.ssh/config
	ln -sf ${PWD}/.htoprc ${HOME}/.htoprc
	ln -sf ${PWD}/.screenrc ${HOME}/.screenrc
	ln -sf ${PWD}/.nanorc ${HOME}/.nanorc
	ln -sf ${PWD}/.tmux.conf ${HOME}/.tmux.conf
	ln -sf ${PWD}/.zsh ${HOME}/.zsh
	ln -sf ${PWD}/.zshrc ${HOME}/.zshrc

X:
	ln -sf ${PWD}/.Xdefaults ${HOME}/.Xdefaults
