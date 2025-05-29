#!/bin/env bash

source ~/.config/alias.sh
eval "$(zoxide init bash --cmd j)"

export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTFILE=$HOME/.local/state/bash_history
export HISTCONTROL=erasedups:ignoredups:ignorespace

shopt -s autocd
shopt -s checkwinsize # update window
shopt -s histappend   # resurrect session history

# prompt
RED='\[\e[31m\]'
GREEN='\[\e[32m\]'
CYAN='\[\e[36m\]'
PINK='\[\e[35m\]'
RESET='\[\e[0m\]'
BASE_PROMPT="${CYAN}\u${RESET}@${GREEN}\h${RESET}:${PINK} \w${RESET} > "
function set_prompt {
    [ $? -ne 0 ] && PS1="$RED[Error]$RESET\n$BASE_PROMPT" || PS1="$BASE_PROMPT"
}
PROMPT_COMMAND=set_prompt

bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'
bind '"\C-H": backward-kill-word'
bind '"\eq": "exit\n"'

md() { mkdir -p "$1" && cd "$1"; }
cpg() { cp "$@" && cd "${!#}"; }
mvg() { mv "$@" && cd "${!#}"; }


if ! command -v fish &>/dev/null ; then
    read -p "install base packages? [Y/n]" yn && [ "$yn" = "n" ] && exit
    if command -v "apt" &>/dev/null ; then
        sudo apt update
        sudo apt install -y curl fish zoxide tmux lf fzf htop fd-find ripgrep bat trash-cli wget #fastfetch
        ln -sf $(which batcat) ~/.local/bin/bat && ln -sf $(which fdfind) ~/.local/bin/fd
    elif command -v "pacman" &>/dev/null ; then
        sudo pacman -Syu curl fish zoxide tmux lf fzf htop fd ripgrep bat trash-cli wget fastfetch
    fi
    chsh -s "$(which fish)"
fi
