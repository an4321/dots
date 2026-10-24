function j
	set -l argc (count $argv)
	if test $argc -eq 0
		cd "$HOME/Desktop"
	else if test $argc -eq 1 -a -d $argv[1]
		cd $argv[1]
	else
		set target (jump query $argv || return 1)
		cd "$target" 2>/dev/null
	end
	jump add $PWD >/dev/null
end

function ji; cd "$(jump list | fzf || echo .)"; end
function md; mkdir -p "$argv" && j "$argv"; end
function cpg; cp $argv && j $argv[-1]; end
function mvg; mv $argv && j $argv[-1]; end

function jump
	set -g jump_db "$HOME/.local/state/jump.txt"

	function help
		echo "options: [a add] [r remove] [q query] [l list] [h help]"
	end

	function err
		echo "error: $argv" && return 1
	end

	function add
		for i in $argv
			test ! -d $i && echo "invalid dir" && continue
			set dir (realpath $i)
			grep -qxF -- "$dir" $jump_db && continue
			echo $dir >> $jump_db
			echo "added: $dir"
		end
	end

	function remove
		for i in $argv
			grep -vxF -- "$i" $jump_db > $jump_db.tmp
			mv $jump_db.tmp $jump_db
			echo "removed: $i"
		end
	end

	function query
		test $argv[1] = '.' && set argv[1] "$PWD"

		# terms in order, case-insensitive, shallowest path first
		set pat (string escape --style=regex -- $argv | string join '.*')
		set res (grep -i -- "$pat" $jump_db | awk -F/ '{print NF, $0}' | sort -ns | cut -d' ' -f2-)
		test -z "$res" && err 404

		for i in $res
			test ! -d $i && remove $i && continue
			echo $i && return
		end
	end

	mkdir -p (dirname $jump_db)
	touch $jump_db

	set argc (count $argv)

	switch $argv[1]
		case "" "h" "help"
			help && return
		case "l" "list"
			cat $jump_db
		case "a" "add"
			test $argc -lt 2 && err "nothing to add"
			add $argv[2..-1]
		case "r" "remove"
			test $argc -lt 2 && err "nothing to remove"
			remove $argv[2..-1]
		case "q" "query"
			test $argc -lt 2 && err "nothing to query"
			query $argv[2..-1]
		case "init"
			echo "complete -c j -e -w cd" > ~/.config/fish/completions/j.fish
			add ~/*/ ~/*/*/ ~/Desktop/*/*/ 2>/dev/null
		case "*"
			help && return 1
	end
end
