static void togglelayout(const Arg *arg);

void
togglelayout(const Arg *arg) {
    if (selmon->lt[selmon->sellt] == &layouts[0]) {
        setlayout(&((Arg) { .v = &layouts[2] })); // switch to monocle
    } else {
        setlayout(&((Arg) { .v = &layouts[0] })); // switch to tile
    }
}
