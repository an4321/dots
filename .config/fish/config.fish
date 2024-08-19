set -gx fish_greeting
set -gx fish_hybrid_key_bindings
set -gx fish_cursor_insert line

zoxide init fish --cmd j | source

source ~/Dots/bin/alias.sh
source ~/.config/fish/functions.fish
source ~/.config/fish/local.fish

bind q 'exit'
bind H beginning-of-line
bind L end-of-line

bind -M insert \eq 'exit'
bind -M insert \ef 'fm; commandline -f repaint'
bind -M insert \ec 'cd .; clear; commandline -f repaint'
bind -M insert \ea 'tmux_attach; commandline -f repaint'
bind -M insert \ek 'commandline -i $(history | fzf-tmux -h -e +s); commandline -f repaint'
