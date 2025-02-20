set -gx fish_greeting
fish_hybrid_key_bindings
set -gx fish_cursor_insert line

zoxide init fish --cmd j | source

source ~/dots/bin/alias.sh
source ~/.config/fish/functions.fish
source ~/.config/fish/local.fish

bind q 'exit'
bind H beginning-of-line
bind L end-of-line

bind -M insert \eq 'exit'
bind -M insert \ef 'fm; commandline -f repaint'
bind -M insert \ea 'tmux_attach; commandline -f repaint'

bind -M insert \cH backward-kill-word
bind -M insert \cj 'commandline -t --append " | cat"; commandline -f execute'
bind -M insert \ck 'commandline -i $(history | fzf-tmux -h -e +s); commandline -f repaint'
