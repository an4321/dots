#!/bin/sh

set -eEo pipefail

# sudo apt install -y podman curl
# curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

# https://github.com/89luca89/distrobox/blob/main/docs/posts/execute_commands_on_host.md
# https://github.com/ublue-os/boxkit/blob/main/scripts/distrobox-shims.sh

distrobox create --name archbox --image docker.io/library/archlinux:latest 
distrobox enter --name archbox -- sudo pacman -Syu --noconfirm
distrobox enter --name archbox -- sudo pacman -S --noconfirm zoxide tmux fzf lf fastfetch
distrobox enter --name archbox -- sudo pacman -S --noconfirm zoxide tmux entr
distrobox enter archbox

# trash go
# cat ~/.distroboxrc
# xhost +si:localuser:$USER >/dev/null
