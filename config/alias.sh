
export PATH=$PATH:"/bin:/usr/local/bin:$HOME/.bun/bin:$HOME/dots/bin:$HOME/.local/bin:$HOME/.go/bin:$HOME/.local/go/bin:$HOME/.local/node/bin"
export EDITOR="$HOME/.local/nvim/bin/nvim"
export VISUAL="$HOME/.local/nvim/bin/nvim"
export GOPATH="$HOME/.go"
export GOROOT="$HOME/.local/go"
export MANPAGER="nvim +Man!"
export FZF_DEFAULT_OPTS="--bind='ctrl-space:toggle-preview,ctrl-h:backward-kill-word' --cycle --reverse --prompt ' ' --pointer ' ' --marker='* ' -m --height=20% --color=bg+:blue,hl+:-1,prompt:blue,fg+:black,gutter:-1,border:blue --no-separator --scroll-off=3"
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

alias df="df -h"
alias free="free -h"
alias fetch="fastfetch"
alias fm="lf"

alias y='test -n "$WAYLAND_DISPLAY" && wl-copy || xsel -b'
alias p='test -n "$WAYLAND_DISPLAY" && wl-paste || xsel -bo'
alias yy="history --max=1 | tr -d '\n' | y"
alias ywd="pwd; pwd | y"

alias rg="rg --hidden -g '!{.git,node_modules,.svelte-kit,__pycache__,vendor}' --smart-case --pretty"
alias fd="fd --hidden --follow --color auto --exclude={.git,node_modules,__pycache__,vendor}"

alias fopen='setsid open "$(fd | fzf-tmux -h)"'
alias fo="fopen"

alias pn="pnpm"
alias px="pnpx"

alias ga="git add"
alias gs="git status --short"
alias gb="git branch"
alias gc="git clone"
alias g1="git clone --depth 1"
alias gk="git checkout"
alias gp="git push origin"
alias gr="git pull --rebase origin"
alias gl='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
alias lines="git ls-files | xargs cat | wc -l"

alias emote="env cat ~/.config/rofi/{emotes,nf-icons} | fzf-tmux -h +s -m | cut -d ' ' -f 1 | tr -d '\n' | y"
