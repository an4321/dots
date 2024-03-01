
set fish_greeting
set -gx EDITOR nvim
set -gx VISUAL nvim
set -g fish_key_bindings fish_default_key_bindings

# autojump >/dev/null
zoxide init fish --cmd j | source
starship init fish | source
printf %b '\e]4;4;#6495ed\a'

fish_add_path ~/Dots/bin ~/.cargo/bin ~/.local/bin ~/.bun/bin ~/.cargo/bin
# set --erase --universal fish_user_paths[5]

source ~/.config/fish/functions.fish
source ~/.config/fish/tmux.fish
source ~/Dots/bin/alias.sh

bind \eq 'exit'
bind \ec 'cd .; clear; commandline -f repaint'
bind \ek 'commandline -i $(history | fzf-tmux -h +s) ; commandline -f repaint'
# bind \ef 'echo "Yazi" && yazi ; commandline -f repaint'
bind \ef 'echo "Ranger" && ranger; commandline -f repaint'
bind \ee 'echo " Neovim" && nvim -c ": Oil" ; commandline -f repaint'

# bun
set --export BROWSER "/usr/bin/brave"
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

