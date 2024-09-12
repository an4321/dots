
starship init fish | source

if test (tty) = "/dev/tty1"
    pgrep dwm || startx
end
