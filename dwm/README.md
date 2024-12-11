# DWM
 
```bash
make arch/debian
sudo make clean install
```

## Patches
* [functionalgaps+pertag](https://dwm.suckless.org/patches/functionalgaps/dwm-functionalgaps+pertag-6.2.diff)
* [focusadjacent+pertag](file:patches/focusadjacent+pertag.diff)
    * Based on [focusadjacenttag](https://dwm.suckless.org/patches/focusadjacenttag/dwm-focusadjacenttag-6.3.diff)
* [hide_vacant_tags](https://dwm.suckless.org/patches/hide_vacant_tags/dwm-hide_vacant_tags-6.4.diff)
* [dwm-colorbar](https://dwm.suckless.org/patches/colorbar/dwm-colorbar-6.3.diff)
* [alwayscenter](https://dwm.suckless.org/patches/alwayscenter/dwm-alwayscenter-20200625-f04cac6.diff)
* [removeborder](https://dwm.suckless.org/patches/removeborder/dwm-removeborder-20220626-d3f93c7.diffa)
* [toggle_layout](file:patches/toggle_layout.c)

## Tap to Click and Natural Scroll
```sh
sudoedit /etc/X11/xorg.conf.d/30-touchpad.conf
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"
EndSection
```

## Disable hibernate
```sh
sudoedit /etc/systemd/logind.conf
    HandleLidSwitch=ignore
```

## Hide Grub
```sh
sudoedit /etc/default/grub
    GRUB_TIMEOUT_STYLE=hidden
sudo update-grub
```
