# ~/.config/fish/config.fish
# ~/.config/bash/bashrc

export FM="lf"
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim +Man!"
export BROWSER="/usr/bin/brave"
export TERMINAL=alacritty
export TERM=alacritty

export PATH=$PATH:"/bin:/usr/local/bin:$HOME/.bun/bin:$HOME/Dots/bin:$HOME/.local/bin:$HOME/.cargo/bin"
export FZF_DEFAULT_OPTS=" --bind='ctrl-t:execute(nvim {})+abort' --cycle --reverse --prompt ' ' --pointer ' ' --marker='* ' -m --height=20% --color=bg+:#395b91,gutter:-1 --no-separator --scroll-off=3 --bind J:down,K:up"

alias ..="cd .."
alias ...="cd ../.."

alias vi="nvim"
alias hx="helix"
alias em="emacsclient -c -a 'emacs'"

alias po="poetry"
alias pr="poetry run"
alias py="poetry run python"
alias pe="poetry run nvim"

alias ls="/bin/ls --color=auto --group-directories-first"
alias la="/bin/ls --color=auto --group-directories-first -A"
alias ll="/bin/ls --color=auto --group-directories-first -A1"

alias li="nsxiv -otf ."
alias lir="nsxiv -otf . | xargs -d \n rm"

alias cp="wl-copy"
alias cat="bat -p --theme=OneHalfDark"
alias ywd="/bin/pwd; /bin/pwd | wl-copy"
alias hist="history | fzf-tmux -h +s"

alias yy="history --max=1 | tr -d '\n' | wl-copy"

alias cp="cp -vi"
alias mv="mv -vi"
alias rm="trash"
alias f="/bin/fd --hidden --follow --exclude .git --exclude node_modules --exclude __pycache__ "
alias fd="f --type d"
alias ff="f --type f"

alias .='cd; clear'
alias c="cd .; clear"
alias cj="clear; j"
alias fetch="fastfetch"

# i insensitive -I ignore binary -H print filename -r recursive -n print line number
alias ft="grep --color=always --exclude-dir={.git,node_modules,.vscode,.next} -iIHrn"
alias play="mpv --ytdl-format='bestaudio' --no-resume-playback --speed=1 --cache-secs=15"
alias k="poetry -C ~/Desktop/AI/groq-test run python ~/Desktop/AI/groq-test/one.py ask"
