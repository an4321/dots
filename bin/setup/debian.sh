#!/bin/env bash

set -eEo pipefail

all=false
[ "$1" = "all" ] && all=true

ask() {
    [ "$all" = "true" ] && return 0
        
    local yn
    read -p "$1? [Y/n] " yn && echo
    case "$yn" in
        [yY] | "") return 0 ;;
        *) return 1 ;;
    esac
}

install() { sudo apt install -y "$@"; }

echo -e "\033[30;44m Debian Setup Script \033[0m \n\n"
mkdir -p ~/.local/bin

echo "Updating package list..."
sudo apt update

if ask "Install base tools"; then
    install curl fish zoxide tmux lf fzf htop fd-find ripgrep bat trash-cli stow # fastfetch
fi

if ask "Create helper scripts"; then
    create_script() { echo -e "$2" > "$1" && chmod +x "$1"; }
    create_script ~/.local/bin/bat '#!/bin/env sh\nbatcat $@'
    create_script ~/.local/bin/fd '#!/bin/env sh\nfdfind $@'
    create_script ~/.local/bin/brave '#!/bin/env sh\nbrave-browser --force-device-scale-factor=1.2 $@'
    create_script ~/.local/bin/notes '#!/bin/env sh\nkitty -e nvim --cmd "cd ~/notes" ~/notes/index.md'
fi

if ask "Build DWM"; then
    install copyq dunst feh nemo i3lock rofi arandr
    install brightnessctl pamixer pavucontrol imagemagick libnotify-bin fonts-noto-color-emoji
    install libx11-dev libxft-dev libxinerama-dev xorg psmisc libxrandr-dev 
    cd ~/config/dwm && sudo make clean install
fi

if ask "Install pipewire"; then
    install pipewire pipewire-audio-client-libraries
    install libpipewire-0.3-0 libpipewire-0.3-dev libpipewire-0.3-modules
    install libspa-0.2-bluetooth libspa-0.2-dev libspa-0.2-jack libspa-0.2-modules
    systemctl --user daemon-reload
    systemctl --user --now enable pipewire pipewire-pulse
fi

ask "Setup bluetooth" && install bluez bluetooth blueman && sudo systemctl enable bluetooth

ask "Install TLP" && install tlp && sudo tlp start

ask "Install nerd fonts" && bash ~/dots/bin/setup/install_nf.sh

ask "Make fish the default shell" && chsh -s "$(which fish)"

ask "Install brave" && (curl -fsS https://dl.brave.com/install.sh | sh)

if ask "Install kitty"; then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin
    ln -s ~/.local/kitty.app/bin/kitten ~/.local/bin
fi

if ask "Install nvim"; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    tar xzvf nvim-linux-x86_64.tar.gz
    mv ./nvim-linux-x86_64 ~/.local/nvim
    ln -s ~/.local/nvim/bin/nvim ~/.local/bin
fi

if ask "Install golang"; then
    LATEST_GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n 1)
    wget https://go.dev/dl/${LATEST_GO_VERSION}.linux-amd64.tar.gz
    sudo rm -rf $HOME/.local/go
    sudo tar -C $HOME/.local/go -xzf ${LATEST_GO_VERSION}.linux-amd64.tar.gz
fi
