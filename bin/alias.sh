export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim +Man!"

export PATH=$PATH:"/bin:/usr/local/bin:$HOME/.bun/bin:$HOME/Dots/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:/snap/bin"
export FZF_DEFAULT_OPTS=" --bind='ctrl-space:toggle-preview' --cycle --reverse --prompt ' ' --pointer ' ' --marker='* ' -m --height=20% --color=bg+:#395b91,gutter:-1 --no-separator --scroll-off=3"
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --height=100% --border"

alias ..="cd .."
alias ...="cd ../.."
alias clr="clear"

alias vi="nvim"
alias vim="fd | fzf-tmux -h | xargs -r nvim"
alias hx="helix"
alias em="emacsclient -c -a 'emacs'"
alias se="sudoedit"

alias pn="pnpm"
alias px="pnpx"
alias po="poetry"
alias pr="poetry run"
alias py="poetry run python"
alias pe="poetry run nvim"
alias update="bash -c 'if command -v apt &> /dev/null; then sudo apt update && sudo apt upgrade -y; elif command -v pacman &> /dev/null; then sudo pacman -Syu --noconfirm; fi'"

alias ls="/bin/ls --color=auto --group-directories-first"
alias la="/bin/ls --color=auto --group-directories-first -A"
alias ll="/bin/ls --color=auto --group-directories-first -A1"

alias li="nsxiv -ota ."
alias lir="nsxiv -ota . | xargs -d \n rm"

alias cp="cp -vir"
alias mv="mv -vi"
alias rm="trash"

alias J="clear; j"
alias fetch="fastfetch"
# alias fm="which yazi >/dev/null 2>&1 && yazi || lf"
alias fm="lf"

alias y='copy_to_clipboard'
alias p='paste_from_clipboard'
alias cat="bat -p --theme=OneHalfDark"
alias ywd="/bin/pwd; /bin/pwd | y"
alias hist="history | fzf-tmux -h +s"
alias yy="history --max=1 | tr -d '\n' | y"

alias fd="/bin/fd --hidden --follow --exclude .git --exclude node_modules --exclude __pycache__ --exclude vendor"
alias ff="fd | fzf-tmux -h"
alias ft="grep --color=always --exclude-dir={.git,node_modules,.vscode,.next} -iIHrn"
# i insensitive -I ignore binary -H print filename -r recursive -n print line number

