lay:
	ln -sf $(PWD)/config/* ~/.config
	ls -d  $(PWD)/config/.??* | xargs -r -I {} ln -sf {} ~
	mkdir -p ~/.local/bin ~/Desktop ~/Pictures/{Wallpapers,Screenshots}

unlay:
	find ~/.config -maxdepth 1 -type l -exec unlink {} \;
	find ~ -maxdepth 1 -type l -exec unlink {} \;
