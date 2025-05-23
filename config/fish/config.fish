set -gx fish_greeting
fish_hybrid_key_bindings
set -gx fish_cursor_insert line

zoxide init fish --cmd j | source

source ~/.config/alias.sh
source ~/.config/fish/functions.fish

bind q 'exit'
bind H beginning-of-line
bind L end-of-line

bind -M insert \eq 'exit'
bind -M insert \ef 'fm; commandline -f repaint'
bind -M insert \ea 't menu; commandline -f repaint'
bind -M insert \ck 'commandline -i $(history | fzf-tmux -h -e +s); commandline -f repaint'
bind -M insert \cH backward-kill-word


if test (tty) = "/dev/tty1"
    pgrep dwm || startx
    # pgrep Hyprland || Hyprland
end
