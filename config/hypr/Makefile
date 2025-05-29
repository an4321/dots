hyprland:
	sudo pacman -S hyprland gcc make stow tmux fish zoxide fzf htop neovim
	sudo pacman -S waybar swaync pamixer network-manager-applet blueman swaybg cliphist wlsunset swaylock nsxiv kitty wezterm
	sudo pacman -S trash-cli npm hyprpicker brightnessctl bc nemo tar

audio:
	sudo pacman -S pipewire pipewire-alsa wireplumber
	systemctl --user enable --now wireplumber.service

tlp:
	sudo pacman -S tlp && sudo tlp start

yay:
	sudo pacman -S --needed git base-devel 
	git clone https://aur.archlinux.org/yay.git
	cd yay && makepkg -si && cd .. && rm yay

	yay --noconfirm -S tofi grimblast

all: hyprland audio tlp yay
