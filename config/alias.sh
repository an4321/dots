export PATH=$PATH:"/bin:/usr/local/bin:$HOME/.local/bin:$HOME/dots/bin:$HOME/.go/bin:$HOME/.local/go/bin:$HOME/.local/node/bin:$HOME/.bun/bin"
export ACCENT="yellow"
export EDITOR="$(which nvim)"
export MANPAGER="$(which nvim) +Man!"
export GOPATH="$HOME/.go"
export GOROOT="$HOME/.local/go"
export FZF_DEFAULT_OPTS="--cycle --reverse --no-separator --scroll-off=3 \
	--prompt ' ' --pointer ' ' --marker='* ' -m --height=20% \
	--bind='ctrl-space:toggle-preview,ctrl-h:backward-kill-word' \
	--color=bg+:$ACCENT,hl+:0,prompt:$ACCENT,fg+:black,gutter:-1,border:$ACCENT"

alias ..="cd .."
alias ...="cd ../.."
alias cp="cp -vir"
alias mv="mv -vi"
alias ln="ln -sv"
alias rm="trash"
alias df="df -h"
alias free="free -h"
alias fetch="fastfetch"
alias fm="lf"
alias cat="bat -p --theme=ansi"
alias e="nvim"
alias se="sudoedit"
alias ls="env ls -G --color=auto --group-directories-first"
alias li="nsxiv -ota ."
alias y='test -n "$WAYLAND_DISPLAY" && wl-copy || xsel -b'
alias p='test -n "$WAYLAND_DISPLAY" && wl-paste || xsel -bo'
alias yy="history --max=1 | tr -d '\n' | y"
alias ywd="pwd; pwd | y"
alias fo='runbg xdg-open "$(fd | fzf-tmux -h)"'
alias x='xargs -I "jk"'
complete -c x -w env

export IGNORE="node_modules,.next,.svelte-kit,__pycache__,vendor,.venv,vendor"
alias rg="rg --hidden --smart-case --pretty -g '!{.git,$IGNORE}'"
alias fd="fd --hidden --follow --color auto --exclude={.git,$IGNORE}"
alias rs="rsync -aPhz --update --exclude={$IGNORE}"

alias lg="lazygit"
alias gcl="git clone"
alias gcb="git clone --bare"
alias gc1="git clone --depth 1"
alias gb="git branch"
alias gc="git checkout"
alias gp="git push origin"
alias gib="git init --bare"
alias gw="git worktree"
alias gwa="git worktree add"
alias gwr="git worktree remove"
alias gl='git log --graph --all \
	--pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
alias lines="git ls-files | xargs cat | wc -l"
