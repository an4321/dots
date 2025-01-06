# starship init fish | source

# alias laptop="bash -c '(hyprctl keyword monitor eDP-1,preferred,0x0,1 && hyprctl keyword monitor DP-1,disable) || (xrandr --output eDP --primary --mode 1920x1200 --pos 0x0 --rotate normal --output HDMI-A-0 --off --output DisplayPort-0 --off)'"
# alias desktop="bash -c '(hyprctl keyword monitor eDP-1,disable && hyprctl keyword monitor DP-1,1920x1080@120,0x0,1) || (xrandr --output eDP --off --output HDMI-A-0 --off --output DisplayPort-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal)'"
# alias hybrid="bash -c '(hyprctl keyword monitor eDP-1,preferred,0x0,1 && hyprctl keyword monitor DP-1,1920x1080@120,0x-1080,1) || (xrandr --output eDP --primary --mode 1920x1200 --pos 0x1080 --output HDMI-A-0 --off --output DisplayPort-0 --mode 1920x1080 --pos 0x0)'"

if test (tty) = "/dev/tty1"
    pgrep dwm || startx
    # pgrep Hyprland || Hyprland
end
