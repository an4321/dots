install:
	sudo pacman -S hyprland
	sudo pacman -S gcc make stow tmux fish zoxide fzf htop neovim
	sudo pacman -S waybar swaync pamixer network-manager-applet blueman swaybg cliphist wlsunset swaylock nsxiv alacritty wezterm

audio:
	sudo pacman -S pipewire pipewire-alsa wireplumber
	systemctl --user enable --now wireplumber.service

shell:
	chsh -s $(which fish)

yay:
	sudo pacman -S --needed git base-devel 
	git clone https://aur.archlinux.org/yay.git
	cd yay && makepkg -si && cd .. && rm yay

	yay --noconfirm -S tofi grimblast hyprpicker-bin

fonts:
	bash install_nf
	git clone https://github.com/githubnext/monaspace
	cd monaspace && bash util/install_linux.sh && cd .. && rm monaspace

all: audio install shell yay fonts
