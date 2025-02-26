#!/bin/env bash

source ~/dots/bin/alias.sh

export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTFILE=$HOME/.local/state/bash_history
export HISTCONTROL=erasedups:ignoredups:ignorespace

RED='\033[31m'
GREEN='\033[32m'
CYAN='\033[36m'
PINK='\033[35m'
RESET='\033[0m'
export PS1="${CYAN}\u${RESET}@${GREEN}\h${RESET}: ${PINK}\w${RESET} \
\$(if [ \$? = 0 ]; then echo \"\"; else echo \"${RED}\"; fi)${RESET} "

eval "$(zoxide init bash --cmd j)"
printf %b '\e]4;4;#6495ed\a'

shopt -s autocd
shopt -s checkwinsize # Update Window
shopt -s histappend   # Resorect session history

bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'
bind '"\C-H": backward-kill-word'

bind '"\eq": "exit\n"'
bind '"\ea": "tmux_attach\n"'
bind '"\C-k": "hist\n"'
alias hist="history | tac | fzf-tmux -h +s"

# set -o vi
# bind 'set keyseq-timeout 50'
# bind 'set show-mode-in-prompt on'
# bind 'set vi-ins-mode-string "\1\e[32m\2[I]\1\e[0m\2 "'
# bind 'set vi-cmd-mode-string "\1\e[31m\2[N]\1\e[0m\2 "'

md() { mkdir -p "$1" && cd "$1"; }
cpg() { cp "$@" && cd "${!#}"; }
mvg() { mv "$@" && cd "${!#}"; }
