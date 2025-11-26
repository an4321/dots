# setup

### disable boot loader
```sh
# grub
sudoedit /etc/default/grub
# change -> GRUB_TIMEOUT_STYLE=hidden
sudo update-grub

# systemd-boot
sudoedit /boot/loader/loader.conf or /efi/loader/loader.conf
# change -> timeout 0
```

### disable hibernate
```sh
sudoedit /etc/systemd/logind.conf
# add -> HandleLidSwitch=ignore
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

### theming
* [gtk theme](https://www.pling.com/p/1441725)
* [icon theme](https://www.pling.com/p/1166289)
* [cursor theme](https://www.gnome-look.org/p/1197198)
```sh
i lxappearance
extract gtkTheme ~/.themes
extract iconTheme ~/.icons
```
