export LC_ALL=en_US.UTF-8
export ACCENT="yellow"
export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export PATH=$PATH:"/bin:/usr/local/bin:$HOME/.local/bin:$HOME/dots/bin:$HOME/.go/bin:$HOME/.local/go/bin:$HOME/.local/node/bin:$HOME/.bun/bin:/snap/bin"
export FZF_DEFAULT_OPTS="--cycle --reverse --no-separator --scroll-off=3 \
	--prompt '  ' --pointer ' ' --marker='* ' -m --height=40% \
	--bind='ctrl-space:toggle-preview,ctrl-h:backward-kill-word',ctrl-d:half-page-down,ctrl-u:half-page-up \
	--color=bg+:$ACCENT,hl+:0,prompt:$ACCENT,fg+:black,gutter:-1,border:$ACCENT"
export IGNORE="node_modules,.next,.svelte-kit,__pycache__,.venv,.cache,.bun,.npm,.local/share"

alias ..="cd .."
alias ...="cd ../.."
alias cp="cp -vir"
alias mv="mv -vi"
alias ln="ln -sv"
alias rm="trash"
alias df="df -h"
alias free="free -h"
alias ff="fastfetch"
alias se="sudoedit"
alias ls="ls -G --color=auto --group-directories-first"
alias la="ls -GA --color=auto --group-directories-first"
alias ywd="pwd | tee /dev/tty | y"
alias li="iv -ota . | tee /dev/tty | y"
alias o='setsid xdg-open'
alias ex='extract'

alias cam="command ffplay -hide_banner -loglevel fatal -stats \
	-window_title webcam -fflags +nobuffer -fast /dev/video0"
alias batt="printf 'capacity: ' && cat /sys/class/power_supply/BAT0/capacity && \
	upower -e | grep 'BAT' | xargs upower -i | grep 'time to' | xargs"

alias poweroff="systemctl poweroff"
alias reboot="systemctl soft-reboot"
alias hard-reboot="systemctl reboot"
alias logout="pkill -u $USER"

alias rg="command rg --hidden --smart-case --pretty -g '!{.git,$IGNORE}'"
alias fd="command fd --hidden --follow --color auto --exclude={.git,$IGNORE}"
alias rs="command rsync -aPhz --update --exclude={$IGNORE}"

alias bx="bunx"
alias br="bun run"
alias ba="bun add"
alias pn="pnpm"
alias pr="pnpm run"
alias px="pnpm dlx"

alias lg="lazygit"
alias gcl="git clone"
alias gc1="git clone --depth 1"
alias gb="git branch"
alias gco="git checkout"
alias gpo="git push origin"
alias gcm="git commit"
alias gi="git init && git branch -m main"
alias gw="git worktree"
alias gs="git status --short --branch --show-stash"
alias gst="git stash && git stash branch temp"
alias grm="git rm --cached --ignore-unmatch"
alias gl='git log --graph --all \
	--pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
alias lines="git ls-files | xargs cat | wc -l"
