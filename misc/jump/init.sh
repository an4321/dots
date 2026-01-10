j() {
	if [ $# -eq 0 ]; then
		cd ~/Desktop
	elif [ $# -eq 1 ] && [ -d "$1" ]; then
		cd "$1"
	else
		target=$(jump query "$@" || return 1)
		cd "$target" 2>/dev/null
	fi
	jump add "$PWD" >/dev/null
}

ji() { cd "$(jump list | fzf-tmux || echo .)"; }
md() { mkdir -p "$1" && cd "$1"; }
cpg() { cp "$@" && cd "${@: -1}"; }
mvg() { mv "$@" && cd "${@: -1}"; }
