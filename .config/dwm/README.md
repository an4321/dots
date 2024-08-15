# DWM
```bash
sudo make clean install
```

## Patches
* [focusadjacenttag](http://dwm.suckless.org/patches/focusadjacenttag)
* [hide_vacant_tags](http://dwm.suckless.org/patches/hide_vacant_tags)
* [alwayscenter](http://dwm.suckless.org/patches/alwayscenter)

## Requirements
```bash
sudo apt install make gcc libx11-dev libxft-dev libxinerama-dev xorg
```
```bash
sudo pacman -S xorg xorg-xinit base-devel libx11 libxft libxinerama
```

## .xinitrc
```bash
while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
do
    sleep 1
done &

xrandr --output DP --mode 1920x1080

exec dwm
```
