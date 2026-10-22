{ config, pkgs, lib, ... }:

let
	dotfiles = "${config.home.homeDirectory}/nixos/config";
	configs = [ "hypr" "kitty" "fish" "nvim" "lazygit" "fd" "mpv" ];

	scriptNames = lib.attrNames (lib.filterAttrs (_: type: type == "regular") (builtins.readDir ./scripts));
	mkScript = name: pkgs.writeScriptBin name (builtins.readFile ./scripts/${name});
in {
	home.username = "user";
	home.homeDirectory = "/home/user";
	home.stateVersion = "26.05";
	programs.git = {
		enable = true;
		userName = "anurag";
		userEmail = "anuragp.5984@gmail.com";
	};

	xdg.configFile = builtins.listToAttrs (map (name: {inherit name; value = {
		source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${name}";
		recursive = true;
	}; }) configs);

	home.packages = (map mkScript scriptNames) ++ (with pkgs; [
		wget ripgrep fd fzf htop lazygit fastfetch trash-cli
		libnotify wl-clipboard cliphist networkmanagerapplet brightnessctl
		kitty waybar rofi dunst swaybg swaylock grim slurp
		neovim nemo mpv foliate
	]);

	# theming
	gtk = {
		enable = true;
		theme.name = "Orchis-Dark";
		theme.package = pkgs.orchis-theme;
		iconTheme.name = "Papirus-Dark";
		iconTheme.package = pkgs.papirus-icon-theme;
	};
	dconf.settings."org/gnome/desktop/interface" = {
		color-scheme = "prefer-dark";
		gtk-theme = "Orchis-Dark";
	};
	qt = {
		enable = true;
		platformTheme.name = "gtk";
		style.name = "adwaita-dark";
	};
	home.pointerCursor = {
		enable = true;
		gtk.enable = true;
		x11.enable = true;
		hyprcursor.enable = true;
		name = "Bibata-Modern-Classic";
		package = pkgs.bibata-cursors;
		size = 26;
	};
}
