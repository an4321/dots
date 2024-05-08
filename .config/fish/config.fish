source ~/.config/fish/functions.fish
source ~/Dots/bin/alias.sh

fish_vi_key_bindings
set fish_cursor_insert line
set fish_greeting

zoxide init fish --cmd j | source
starship init fish | source

bind q 'exit'
bind P 'fish_clipboard_paste'
bind H beginning-of-line
bind L end-of-line

bind -M insert \eq 'exit'
bind -M insert \ef '$FM; commandline -f repaint'
bind -M insert \ec 'cd .; clear; commandline -f repaint'
bind -M insert \ea 'tmux_attach; commandline -f repaint'
bind -M insert \ek 'commandline -i $(history | fzf-tmux -h +s); commandline -f repaint'

