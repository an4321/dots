#!/bin/env bash

set -eEo pipefail

sudo apt remove -y nano
sudo apt update

# base
read -p "install base tools? (y/N) " -n 1 yn
echo
if [[ $yn =~ ^[Yy]$ ]]; then
    sudo apt install -y brightnessctl pamixer libnotify-bin copyq dunst feh nemo i3lock
    sudo apt install -y fonts-noto-color-emoji arandr pavucontrol imagemagick

    sudo apt install -y curl fish zoxide tmux lf fzf htop fd-find ripgrep bat trash-cli stow # fastfetch
    (read -p "make fish default (y/N) " yn && [[ $yn =~ ^[Yy]$ ]] && (chsh -s $(which fish)))
fi


# suckless
read -p "build suckless tool? (y/N) " -n 1 yn
echo
if [[ $yn =~ ^[Yy]$ ]]; then
    sudo apt install -y gcc libx11-dev libxft-dev libxinerama-dev xorg psmisc libxrandr-dev 
    cd ~/config/dwm && sudo make clean install
    cd ~/config/dmenu && sudo make clean install
    cd ~/config/st && sudo make clean install

    sudo apt install -y libexif-dev libfontconfig1-dev libinotifytools0-dev
    cd ~/config/nsxiv && sudo make install && sudo make install-desktop install-icon
fi


# audio
read -p "install pipewire? (y/N) " -n 1 yn
echo
if [[ $yn =~ ^[Yy]$ ]]; then
    sudo apt install -y pipewire pipewire-audio-client-libraries
    sudo apt install -y libpipewire-0.3-0 libpipewire-0.3-dev libpipewire-0.3-modules
    sudo apt install -y libspa-0.2-bluetooth libspa-0.2-dev libspa-0.2-jack libspa-0.2-modules
    systemctl --user daemon-reload
    systemctl --user --now enable pipewire pipewire-pulse
fi


# bluetooth
(read -p "setup bluetooth (y/N) " yn && [[ $yn =~ ^[Yy]$ ]] && (sudo apt install -y bluez bluetooth blueman && sudo systemctl enable bluetooth))

# tlp
(read -p "install tlp (y/N) " yn && [[ $yn =~ ^[Yy]$ ]] && (sudo apt install -y tlp && sudo tlp start))

# fonts
(read -p "install nerd fonts (y/N) " yn && [[ $yn =~ ^[Yy]$ ]] && (bash ~/dots/bin/setup/install_nf.sh))


# download and install scripts
mkdir -p ~/.local/bin


# kitty
read -p "install kitty? (y/N) " -n 1 yn
echo
if [[ $yn =~ ^[Yy]$ ]]; then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin
    ln -s ~/.local/kitty.app/bin/kitten ~/.local/bin
fi


# neovim
read -p "install nvim appimage? (y/N) " -n 1 yn
echo
if [[ $yn =~ ^[Yy]$ ]]; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    tar xzvf nvim-linux-x86_64.tar.gz
    mv ./nvim-linux-x86_64 ~/.local/nvim
    ln -s ~/.local/nvim/bin/nvim ~/.local/bin
fi


read -p "install golang? (y/N) " -n 1 yn
echo
if [[ $yn =~ ^[Yy]$ ]]; then
    LATEST_GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n 1)

    wget https://go.dev/dl/${LATEST_GO_VERSION}.linux-amd64.tar.gz
    sudo rm -rf $HOME/.local/go

    sudo tar -C $HOME/.local/go -xzf ${LATEST_GO_VERSION}.linux-amd64.tar.gz
fi


# brave
(read -p "install brave (y/N) " yn && [[ $yn =~ ^[Yy]$ ]] && (curl -fsS https://dl.brave.com/install.sh | sh))


# creating scripts
create_script() {
  echo -e "$2" > "$1"
  chmod +x "$1"
}

read -p "create helper scripts? (y/N) " -n 1 yn
echo
if [[ $yn =~ ^[Yy]$ ]]; then
    create_script ~/.local/bin/bat '#!/bin/env sh\nbatcat $@'
    create_script ~/.local/bin/fd '#!/bin/env sh\nfdfind $@'
    create_script ~/.local/bin/brave '#!/bin/env sh\nbrave-browser --force-device-scale-factor=1.2 $@'
    create_script ~/.local/bin/notes '#!/bin/env sh\nkitty -e nvim --cmd "cd ~/notes" ~/notes/index.md'
fi

