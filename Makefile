lay:
	ln -sf $(PWD)/config/* ~/.config
	ls -d  $(PWD)/config/.??* | xargs -r -I {} ln -sf {} ~

unlay:
	find ~/.config -maxdepth 1 -type l -exec unlink {} \;
	find ~ -maxdepth 1 -type l -exec unlink {} \;
