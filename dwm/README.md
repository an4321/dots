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
    ```c
    void
    togglelayout(const Arg *arg) {
        if (selmon->lt[selmon->sellt] == &layouts[0]) {
            setlayout(&((Arg) { .v = &layouts[2] })); // switch to monocle
        } else {
            setlayout(&((Arg) { .v = &layouts[0] })); // switch to tile
        }
    }
    ```

