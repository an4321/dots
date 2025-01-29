# DWM
 
```bash
make arch/debian
sudo make clean install
```

## patches
* [functionalgaps+pertag](https://dwm.suckless.org/patches/functionalgaps/dwm-functionalgaps+pertag-6.2.diff)
* [focusadjacent+pertag](file:patches/focusadjacent+pertag.diff)
    * Based on [focusadjacenttag](https://dwm.suckless.org/patches/focusadjacenttag/dwm-focusadjacenttag-6.3.diff)
* [hide_vacant_tags](https://dwm.suckless.org/patches/hide_vacant_tags/dwm-hide_vacant_tags-6.4.diff)
* [dwm-colorbar](https://dwm.suckless.org/patches/colorbar/dwm-colorbar-6.3.diff)
* [alwayscenter](https://dwm.suckless.org/patches/alwayscenter/dwm-alwayscenter-20200625-f04cac6.diff)
* [removeborder](https://dwm.suckless.org/patches/removeborder/dwm-removeborder-20220626-d3f93c7.diffa)
* [toggle_layout](file:patches/toggle_layout.c)

## settings for x

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

### disable hibernate
```sh
sudoedit /etc/systemd/logind.conf
# add -> HandleLidSwitch=ignore
```

### hide grub
```sh
sudoedit /etc/default/grub
# add -> GRUB_TIMEOUT_STYLE=hidden

sudo update-grub
```

### non free
```sh
sudoedit /etc/apt/sources.list
# add -> non-free non-free-firmware
# deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
# deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
# deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

sudo apt update
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

