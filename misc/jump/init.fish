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
complete -c j -e -w cd

function ji; cd "$(jump list | fzf-tmux || echo .)"; end
function md; mkdir -p "$argv" && j "$argv"; end
function cpg; cp $argv && j $argv[-1]; end
function mvg; mv $argv && j $argv[-1]; end
