# ~/.config/fish/config.fish
# ~/.config/bash/bashrc

export EDITOR=nvim
export MANPAGER="nvim +Man!"

export PATH=$PATH:"/bin:/usr/local/bin:$HOME/.bun/bin:$HOME/Dots/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin"
export FZF_DEFAULT_OPTS=" --bind='ctrl-e:execute(nvim {})+abort' --cycle --reverse --prompt ' ' --pointer ' ' --marker='* ' -m --height=20% --color=bg+:#395b91,gutter:-1 --no-separator --scroll-off=3"
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --height=100% --border"

alias ..="cd .."
alias ...="cd ../.."
alias clr="clear"

alias fm="which yazi >/dev/null 2>&1 && yazi || lf"
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

alias li="nsxiv -otfa ."
alias lir="nsxiv -otfa . | xargs -d \n rm"

alias cp="cp -vi"
alias mv="mv -vi"
alias rm="trash"

alias J="clear; j"
alias fetch="fastfetch"

alias y='copy_to_clipboard'
alias p='paste_from_clipboard'
alias cat="bat -p --theme=OneHalfDark"
alias ywd="/bin/pwd; /bin/pwd | y"
alias hist="history | fzf-tmux -h +s"
alias yy="history --max=1 | tr -d '\n' | y"

alias fd="/bin/fd --hidden --follow --exclude .git --exclude node_modules --exclude __pycache__ --type d"
alias ff="/bin/fd --hidden --follow --exclude .git --exclude node_modules --exclude __pycache__ --type f"
alias ft="grep --color=always --exclude-dir={.git,node_modules,.vscode,.next} -iIHrn"
# i insensitive -I ignore binary -H print filename -r recursive -n print line number

