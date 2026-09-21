# Configuration Notes

## git
```fish
git config --global user.name "$name"
git config --global user.email "$email"

# generate ssh key pair if you haven't already
ssh-keygen -t ed25519 -C "$email"

# add ssh key to agent
bash -c "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

* add the public key to github:
  1. go to github settings
  2. in the sidebar, click ssh and gpg keys
  3. click new ssh key or add ssh key
  4. paste this: `cat ~/.ssh/id_ed25519.pub`
  5. test connection: `ssh -T git@github.com`

* to set remote origin:
  `git remote set-url origin git@github.com:name/repo.git`

## system

### Gnome
```fish
# options
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:close'
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 5

# faster animations
command mkdir -p ~/.config/environment.d/
echo "GNOME_SHELL_SLOWDOWN_FACTOR=0.5" > ~/.config/environment.d/90-gnome-speed.conf

# workspaces
set workspaces a s d f g
for i in (seq (count $workspaces))
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<alt>$workspaces[$i]']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<alt><shift>$workspaces[$i]']"
end

# # next / preview
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<alt>h']"
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<alt>l']"
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<alt><shift>h']"
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<alt><shift>l']"

# system keybindings
gsettings set org.gnome.desktop.wm.keybindings close "['<alt>q']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<alt><shift>m']"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<alt>m']"
gsettings set org.gnome.shell.keybindings toggle-overview "['<alt>o']"
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<alt>c', 'Print']"

# custom keybindings
gkb set "<alt>z" "xdg-screensaver lock"
gkb set "<alt>t" "xdg-terminal-exec"
gkb set "<alt>e" "xdg-terminal-exec e $HOME/Desktop"
gkb set "<alt>i" "xdg-terminal-exec htop"
gkb set "<alt>w" "xdg-open http://"
gkb set "<shift><alt>w" "helium --incognito"
gkb set "<alt>f" "xdg-open file://$HOME"
gkb set "<alt>r" "setbg"
gkb set "<alt>n" "sh -c 'cd $HOME/notes && kitty -1 nvim index.md'"

# set kitty as the default terminal
echo "kitty.desktop" > ~/.config/xdg-terminals.list
```

### dont show boot loader
```sh
# grub
sudoedit /etc/default/grub
# change -> GRUB_TIMEOUT_STYLE=hidden

# on debian
sudo update-grub
# on arch
sudo grub-mkconfig -o /boot/grub/grub.cfg

# systemd-boot
sudoedit /boot/loader/loader.conf or /efi/loader/loader.conf
# change -> timeout 0
```

### disable hibernate
```sh
sudoedit /etc/systemd/logind.conf
# add -> HandleLidSwitch=ignore
```

### auto login
* [getty arch wiki](ahttps://wiki.archlinux.org/title/Getty)

```sh
# this
sudo systemctl edit getty@tty1

# or this
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
sudo bash -c 'cat <<EOF >> /etc/systemd/system/getty@tty1.service.d/override.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty -a user --noclear - $TERM
EOF'

# enabling it
sudo systemctl enable getty@tty1.servic
systemctl reboot
```

### big tty font
```sh
sudo pacman -S terminus-font

ls /usr/share/kbd/consolefonts
sudoedit /etc/vconsole.conf # FONT=ter-132n

# should have this by default
sudoedit /etc/mkinitcpio.conf
# find HOOKS=(... keyboard keymap consolefont block ...) <- add consolefonts

sudo mkinitcpio -P
sudo reboot
```

### tap to click & natural scroll
```sh
sudo bash -c 'cat <<EOF >> /etc/X11/xorg.conf.d/30-touchpad.conf
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"
EndSection
EOF'
```

### misc

* disable sudo for brightnessctl `sudo usermod -aG video $USER`
  or `sudo visudo` -> <user> ALL=(ALL) NOPASSWD: /usr/bin/brightnessctl

* tldr bluetoothctl ::
```sh
power on
agent on
default-agent
scan on
pair XX:XX:XX:XX:XX:XX
connect XX:XX:XX:XX:XX:XX
trust XX:XX:XX:XX:XX:XX
scan off
exit
```

* firefox `about:config`
  toggle alt menu: `ui.key.menuAccessKeyFocuses`
  scale: `devPixelsPerPx`
  gestures: `browser.gesture.swipe`

