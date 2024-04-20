
# ~/.config/fish/config.fish
# ~/.config/bash/bashrc

export XDG_CONFIG_HOME="$HOME/.config"
export BROWSER="/usr/bin/brave"
export MANPAGER="nvim +Man!"
export FZF_DEFAULT_OPTS=" --bind='ctrl-t:execute(nvim {})+abort' --cycle --reverse --prompt ' ' --pointer ' ' --marker='✔' -m --height=20% --color=bg+:#395b91,gutter:-1 --no-separator --scroll-off=3 --bind J:down,K:up"

alias ..="cd .."
alias ...="cd ../.."

alias vi="nvim"
alias vim="nvim -c ':Oil'"
alias em="emacsclient -c "

alias pn="pnpm"
alias px="pnpx"
alias po="poetry"
alias db="distrobox"

alias ls="/bin/ls --color=auto --group-directories-first"
alias la="/bin/ls --color=auto --group-directories-first -A"
alias ll="/bin/ls --color=auto --group-directories-first -A1"
alias lp="nsxiv -otf ."

alias cat="bat -p --theme=OneHalfDark"
alias tree="exa --icons --tree --group-directories-first"
alias ywd="/bin/pwd; /bin/pwd | wl-copy"
alias hist="history | fzf | bash"

alias yy="history --max=1 | tr -d '\n' | wl-copy"
#TODO
# alias yp="LAST_OUT=$(history --max=1 | tr -d '\n'); echo '$LAST_OUT' | xargs -d \n wl-copy"

alias cp="cp -vi"
alias mv="mv -vi"
alias rm="trash"
alias fd="fd --hidden --follow --exclude .git --exclude .vscode --exclude node_modules"

# alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias .='cd; clear'
alias c="cd .; clear"
alias cj="clear; j"
alias nf="neofetch "
alias live="$HOME/dots/scripts/live && sleep 0.5"
alias icat="kitty +kitten icat"
alias opacity="~/.config/alacritty/opacity_alacritty.sh"

alias f="ollama run mistral"
# -i insensitive -I ignore binary -H print filename -r recursive -n print line number
alias ft="grep --color=always --exclude-dir={.git,node_modules,.vscode,.next} -iIHrn"

alias play="mpv --ytdl-format='bestaudio' --no-resume-playback --speed=1 --cache-secs=15"

