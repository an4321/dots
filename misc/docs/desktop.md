# Neovim
```sh
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar xzvf nvim-linux-x86_64.tar.gz
rm -rf nvim-linux-x86_64.tar.gz
mv ./nvim-linux-x86_64 ~/.local/nvim
ln -s ~/.local/nvim/bin/nvim ~/.local/bin
```

# Kitty
```sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin
ln -s ~/.local/kitty.app/bin/kitten ~/.local/bin
```

# Brave
```fish
# arch
i brave-bin
# debian
curl -fsS "https://dl.brave.com/install.sh" | sh

begin
	echo '#!/bin/env sh'
	echo 'brave-browser --force-device-scale-factor=1.2 $@'
end >"$HOME/.local/bin/brave" && chmod +x "$HOME/.local/bin/brave"
```

# TLP
```sh
# debian
sudo apt install -y tlp
# arch
sudo pacman -S tlp

sudo tlp start

echo -e "\nSTART_CHARGE_THRESH_BAT0=70\nSTOP_CHARGE_THRESH_BAT0=91" \
    | sudo tee -a /etc/tlp.conf
sudo systemctl restart tlp
```

# UFW
```sh
# debian
sudo apt install -y ufw
# arch
sudo pacman -S ufw

sudo systemctl enable ufw
sudo systemctl start ufw

sudo ufw default allow outgoing
sudo ufw default deny incoming

sudo ufw enable
sudo ufw status verbose
```

# Random Wallpaper
```fish
mkdir -p ~/Pictures/wallpapers
test -z "$(ls $HOME/Pictures/wallpapers)" && accept "get a wallpaper?" \
    && wget -O "$HOME/Pictures/wallpapers/$(random).png" "https://picsum.photos/1920/1080?random"
```
