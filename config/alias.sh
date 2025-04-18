
export PATH=$PATH:"/bin:/usr/local/bin:$HOME/.bun/bin:$HOME/dots/bin:$HOME/.local/bin:$HOME/.go/bin:$HOME/.local/go/bin"
export EDITOR=nvim
export VISUAL=nvim
export GOPATH="$HOME/.go"
export GOROOT="$HOME/.local/go"
export MANPAGER='nvim +Man!'
export FZF_DEFAULT_OPTS="--bind='ctrl-space:toggle-preview,ctrl-l:backward-kill-word' --cycle --reverse --prompt ' ' --pointer ' ' --marker='* ' -m --height=20% --color=bg+:blue,hl+:-1,prompt:blue,fg+:black,gutter:-1,border:blue --no-separator --scroll-off=3"
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --height=100% --border"

alias ..="cd .."
alias ...="cd ../.."
alias clr="clear"
alias cp="cp -vir"
alias mv="mv -vi"
alias ln="ln -sv"
alias rm="trash"

alias ls="env ls --color=auto --group-directories-first"
alias la="env ls --color=auto --group-directories-first -A"
alias li="nsxiv -ota ."
alias lir="nsxiv -ota . | xargs -d \n rm"

alias cat="bat -p --theme=OneHalfDark"
alias vi="nvim"
alias se="sudoedit"
alias hx="helix"

alias df='df -h'
alias free='free -h'
alias fetch="fastfetch 2>/dev/null || neofetch"
alias fm="lf"

alias ywd="pwd; pwd | y"
alias yy="history --max=1 | tr -d '\n' | y"
alias update="bash -c 'if command -v apt &> /dev/null; then sudo apt update && sudo apt upgrade -y; elif command -v pacman &> /dev/null; then sudo pacman -Syu --noconfirm; fi'"
alias emote="env cat ~/dots/bin/assets/{emotes,nf-icons} | fzf-tmux -h +s -m | cut -d ' ' -f 1 | tr -d '\n' | y"

alias rg="rg --hidden -g '!{.git,node_modules,.svelte-kit,__pycache__,vendor}' --smart-case --pretty"
alias fd="fd --hidden --follow --color auto --exclude .git --exclude node_modules --exclude __pycache__ --exclude vendor"
alias fvi="fd -t f | fzf-tmux -h | xargs nvim"
alias fopen='setsid open "$(fd | fzf-tmux -h)"'
alias fo="fopen"

alias pn="pnpm"
alias px="pnpx"

alias archbox="distrobox enter archbox"
alias archrun="distrobox enter archbox --"
alias basic_setup="i fish tmux zoxide trash-cli"
alias remove_binary_files="find -maxdepth 1 -type f -exec file {} \; | grep -v "text" | cut -d: -f1 | xargs rm"
