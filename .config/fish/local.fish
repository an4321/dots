
starship init fish | source
alias laptop="hyprctl keyword monitor eDP-1,preferred,0x0,1 && hyprctl keyword monitor DP-1,disable"
alias desktop="hyprctl keyword monitor eDP-1,disable && hyprctl keyword monitor DP-1,1920x1080@120,0x0,1"
alias hybrid="hyprctl keyword monitor eDP-1,preferred,0x0,1 && hyprctl keyword monitor DP-1,1920x1080@120,0x-1080,1"

if test (tty) = "/dev/tty1"
    # pgrep dwm || startx
    pgrep Hyprland || Hyprland
end
