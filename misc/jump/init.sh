j() {
	if [ $# -eq 0 ]; then
		cd ~/Desktop
	elif [ "$1" = "-" ]; then
		cd -
	elif [ $# -eq 1 ] && [ -d "$1" ]; then
		cd "$1"
	else
		cd "$(jump query "$@" || return 1)" 2>/dev/null
	fi
	jump add "$PWD" >/dev/null
}

ji() {
	cd "$(jump list | fzf-tmux || echo .)"
}
