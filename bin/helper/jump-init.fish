function j --wraps=cd
    set -l argc (count $argv)
    if test $argc -eq 0
        cd "$HOME/Desktop"
    else if test "$argv" = -
        cd -
    else if test $argc -eq 1 -a -d $argv[1]
        cd $argv[1]
    else
        cd "$(jump query $argv || return 1)" 2>/dev/null
    end
	jump add $PWD >/dev/null
end

function ji
	cd "$(jump list | fzf-tmux || echo .)"
end
