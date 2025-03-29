#!/bin/env bash

set -eEo pipefail

# make this in lua maybe
# fix: fd and bat
# add git retry to install_nf
# fastfetch
# nsxiv: imlib2dev libxifdev
# zen

# suckless:
sudo apt remove -y nano
sudo apt update
sudo apt install -y gcc libx11-dev libxft-dev libxinerama-dev xorg psmisc
cd ~/dots/dwm && sudo make clean install && make clean
cd ~/dots/dmenu && sudo make clean install && make clean
cd ~/dots/st && sudo make clean install && make clean

# base:
sudo apt install -y curl fish zoxide tmux lf fzf htop fd-find ripgrep bat trash-cli stow
chsh -s $(which fish)

sudo apt install -y brightnessctl pamixer libnotify-bin slock copyq dunst feh thunar
sudo apt install -y golang fonts-noto-color-emoji arandr pavucontrol imagemagick

# fonts:
bash ~/dots/bin/setup/install_nf.sh

# audio:
sudo apt install -y pipewire pipewire-audio-client-libraries
sudo apt install -y libpipewire-0.3-0 libpipewire-0.3-dev libpipewire-0.3-modules
sudo apt install -y libspa-0.2-bluetooth libspa-0.2-dev libspa-0.2-jack libspa-0.2-modules
systemctl --user daemon-reload
systemctl --user --now enable pipewire pipewire-pulse

# bluetooth:
sudo apt install -y bluez bluetooth blueman
sudo systemctl enable bluetooth

# tlp:
sudo apt install -y tlp && sudo tlp start

mkdir -p ~/.local/bin

# kitty
read -p "install kitty? (y/N) " -n 1 yn
echo
if [[ $yn =~ ^[Yy]$ ]]; then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin
    ln -s ~/.local/kitty.app/bin/kitten ~/.local/libnotify-bin
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

# neovim appimage
# read -p "install nvim appimage? (y/N) " -n 1 yn
# echo
# if [[ $yn =~ ^[Yy]$ ]]; then
#     curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
#     chmod u+x nvim-linux-x86_64.appimage
#     mv ./nvim-linux-x86_64.appimage ~/.local/bin/nvim
# fi

# brave
(read -p "install brave (y/N) " yn && [[ $yn =~ ^[Yy]$ ]] && (curl -fsS https://dl.brave.com/install.sh | sh))

