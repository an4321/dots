#!/bin/env bash

source ~/Dots/bin/alias.sh

export HISTSIZE=1000
export HISTFILESIZE=10000
export HISTFILE=$HOME/.local/state/bash_history
export HISTCONTROL=erasedups:ignoredups:ignorespace
export PS1='\[\e[0;36m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]: \[\e[0;35m\]\w\[\e[0m\]  '

eval "$(zoxide init bash --cmd j)"
printf %b '\e]4;4;#6495ed\a'

shopt -s checkwinsize # Update Window
shopt -s histappend   # Resorect session history

bind 'TAB:menu-complete'
bind '"\C-H": backward-kill-word'
bind '"\eq": "exit\n"'
bind '"\ea": "tmux_attach\n"'

md(){
	mkdir -p "$1"
	cd "$1"
}
