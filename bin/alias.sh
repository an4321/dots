export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim +Man!"

export PATH=$PATH:"/bin:/usr/local/bin:$HOME/.bun/bin:$HOME/Dots/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:/snap/bin"
export FZF_DEFAULT_OPTS=" --bind='ctrl-space:toggle-preview,ctrl-l:backward-kill-word' --cycle --reverse --prompt ' ' --pointer ' ' --marker='* ' -m --height=20% --color=bg+:#395b91,gutter:-1 --no-separator --scroll-off=3"
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --height=100% --border"

alias ..="cd .."
alias ...="cd ../.."
alias clr="clear"
alias cp="cp -vir"
alias mv="mv -vi"
alias rm="trash"

alias ls="/bin/ls --color=auto --group-directories-first"
alias la="/bin/ls --color=auto --group-directories-first -A"
alias li="nsxiv -ota ."
alias lir="nsxiv -ota . | xargs -d \n rm"

alias vi="nvim"
alias vim="fd -t f | fzf-tmux -h | xargs -r nvim"
alias se="sudoedit"
alias hx="helix"
alias em="emacsclient -c -a 'emacs'"

alias df='df -h'
alias free='free -h'
alias fetch="fastfetch 2>/dev/nul | neofetch"
# alias fm="which yazi >/dev/null 2>&1 && yazi || lf"
alias fm="lf"

alias cat="bat -p --theme=OneHalfDark"
alias ywd="pwd; pwd | y"
alias yy="history --max=1 | tr -d '\n' | y"
alias update="bash -c 'if command -v apt &> /dev/null; then sudo apt update && sudo apt upgrade -y; elif command -v pacman &> /dev/null; then sudo pacman -Syu --noconfirm; fi'"

alias rg="rg --hidden -g '!{.git,node_modules,.svelte-kit,__pycache__,vendor}' --smart-case --pretty"
alias fd="/bin/fd --hidden --follow --color auto --exclude .git --exclude node_modules --exclude __pycache__ --exclude vendor"

alias pn="pnpm"
alias px="pnpx"
