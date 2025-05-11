lay:
	ln -sf ~/dots/config/* ~/.config
	ls -d ~/dots/config/.??* | xargs -r -I {} ln -sf {} ~

unlay:
	find ~/.config -maxdepth 1 -type l -exec unlink {} \;
	find ~ -maxdepth 1 -type l -exec unlink {} \;

system: lay
	~/dots/bin/setup-debian all
