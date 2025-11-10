export PATH=$PATH:"/bin:/usr/local/bin:$HOME/.local/bin:$HOME/dots/bin:$HOME/.go/bin:$HOME/.local/go/bin:$HOME/.local/node/bin:$HOME/.bun/bin"
export IGNORE="node_modules,.next,.svelte-kit,__pycache__,vendor,.venv,vendor,.cache,.bun,.npm,.local/share"
export ACCENT="yellow"
export EDITOR="$(which nvim)"
export MANPAGER="$(which nvim) +Man!"
export GOPATH="$HOME/.go"
export GOROOT="$HOME/.local/go"
export FZF_DEFAULT_OPTS="--cycle --reverse --no-separator --scroll-off=3 \
	--prompt ' ' --pointer ' ' --marker='* ' -m --height=40% \
	--bind='ctrl-space:toggle-preview,ctrl-h:backward-kill-word',ctrl-d:half-page-down,ctrl-u:half-page-up \
	--color=bg+:$ACCENT,hl+:0,prompt:$ACCENT,fg+:black,gutter:-1,border:$ACCENT"

alias ..="cd .."
alias ...="cd ../.."
alias cp="cp -vir"
alias mv="mv -vi"
alias ln="ln -sv"
alias rm="trash"
alias RM="command rm -rf"
alias df="df -h"
alias free="free -h"
alias fetch="fastfetch"
alias cat="bat -p --theme=ansi"
alias icat="kitty +icat"
alias e="nvim"
alias se="sudoedit"
alias ls="ls -G --color=auto --group-directories-first"
alias li="nsxiv -ota ."
alias ywd="pwd; pwd | y"
alias x='xargs -I "jk"'
complete -c x -w env

alias batt="echo capacity: $(cat /sys/class/power_supply/BAT0/capacity)%; \
	upower -i $(upower -e | grep 'BAT') | grep 'time to' | xargs"
alias cam="ffplay -hide_banner -loglevel fatal -stats \
	-window_title webcam -fflags +nobuffer -fast /dev/video0"
alias setup='command fd -d 1 -t x . ~/dots/bin/setup \
	| fzf --height=100% --preview-window=bottom --preview="env cat {}" \
	| xargs -I {} env {}'

alias rg="command rg --hidden --smart-case --pretty -g '!{.git,$IGNORE}'"
alias fd="command fd --hidden --follow --color auto --exclude={.git,$IGNORE}"
alias rs="rsync -aPhz --update --exclude={$IGNORE}"

alias br="bun run"

alias lg="lazygit"
alias lines="git ls-files | xargs cat | wc -l"
alias gcl="git clone"
alias gc1="git clone --depth 1"
alias ga="git add"
alias gai="git add -p"
alias gb="git branch"
alias gco="git checkout"
alias gp="git pull"
alias gP="git push origin"
alias gcm="git commit"
alias gcp="git commit && git push origin"
alias gi="git init"
alias gm="git merge"
alias gib="git init --bare"
alias gcb="git clone --bare"
alias gw="git worktree"
alias gwa="git worktree add"
alias gwr="git worktree remove"
alias gs="git status --short --branch --show-stash"
alias gst="git stash && git stash branch temp"
alias gl='git log --graph --all \
	--pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
