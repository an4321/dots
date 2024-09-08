# DWM
 
```bash
make arch/debian
sudo make clean install
```

## Patches
* [functionalgaps](https://dwm.suckless.org/patches/functionalgaps/dwm-functionalgaps+pertag-6.2.diff)
* [focusadjacenttag](https://dwm.suckless.org/patches/focusadjacenttag/dwm-focusadjacenttag-6.3.diff)
* [hide_vacant_tags](https://dwm.suckless.org/patches/hide_vacant_tags/dwm-hide_vacant_tags-6.4.diff)
* [dwm-colorbar](https://dwm.suckless.org/patches/colorbar/dwm-colorbar-6.3.diff)
* [alwayscenter](https://dwm.suckless.org/patches/alwayscenter/dwm-alwayscenter-20200625-f04cac6.diff)
* ToggleLayout

## Tap to Click and Natureal Scroll
```sh
cat /etc/X11/xorg.conf.d/30-touchpad.conf
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"
EndSection
```

