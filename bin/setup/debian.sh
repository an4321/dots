#!/bin/env bash

sudo apt remove -y nano
sudo apt update
sudo apt install -y gcc libx11-dev libxft-dev libxinerama-dev xorg psmisc
cd ~/dots/dwm && sudo make clean install && make clean
cd ~/dots/dmenu && sudo make clean install && make clean

# base:
sudo apt install -y fish zoxide tmux lf fzf htop fd-find ripgrep bat trash-cli
chash -s $(which fish)

sudo apt install -y brightnessctl pamixer libnotify-bin slock copyq dunst feh
sudo apt install -y arandr pavucontrol flameshot

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
read -p "install nvim? (y/N) " -n 1 yn
echo
if [[ $yn =~ ^[Yy]$ ]]; then
    nvim_appimage=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
        | grep "browser_download_url.*appimage" | cut -d '"' -f 4 | head -1)
            wget "$nvim_appimage" -O nvim.appimage
            chmod +x ./nvim.appimage
            mv ./nvim.appimage ~/.local/bin/nvim
fi

# brave
(read -p "install brave (y/N) " yn && [[ $yn =~ ^[Yy]$ ]] && (curl -fsS https://dl.brave.com/install.sh | sh))

