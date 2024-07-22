
# Patches
* [pertag](http://dwm.suckless.org/patches/pertag)
* [focusadjacenttag](http://dwm.suckless.org/patches/focusadjacenttag)
* [movestack](http://dwm.suckless.org/patches/movestack)
* [hide_vacant_tags](http://dwm.suckless.org/patches/hide_vacant_tags)
* [alwayscenter](http://dwm.suckless.org/patches/alwayscenter)

# .xinitrc
```bash
while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
do
    sleep 1
done &
exec dwm
```
