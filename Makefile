lay:
	ln -sf $(PWD)/config/* ~/.config
	ls -d  $(PWD)/config/.??* | xargs -r -I {} ln -sf {} ~
	mkdir -p ~/.local/bin ~/Desktop ~/Pictures/{Wallpapers,Screenshots}

unlay:
	find ~/.config -maxdepth 1 -type l -exec unlink {} \;
	find ~ -maxdepth 1 -type l -exec unlink {} \;

base:
	sudo apt update
	sudo apt install -y curl fish zoxide tmux lf fzf htop fd-find ripgrep bat trash-cli wget # fastfetch
	ln -sf $(which batcat) ~/.local/bin/bat
	ln -sf $(which fdfind) ~/.local/bin/fd
	chsh -s "$(which fish)"

base-arch:
	sudo pacman -Syu curl fish zoxide tmux lf fzf htop fd ripgrep bat trash-cli wget fastfetch
