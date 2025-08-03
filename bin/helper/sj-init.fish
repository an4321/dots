if ! builtin functions --query _sj_cd
    if builtin functions --query cd
        builtin functions --copy cd _sj_cd
    else
        alias _sj_cd='builtin cd'
    end
end

function _sj_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command sj add (builtin pwd -L) >/dev/null
end

function j
    set -l argc (count $argv)
    if test $argc -eq 0
        _sj_cd "$HOME/Desktop"
    else if test "$argv" = -
        _sj_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        _sj_cd $argv[1]
    else
	_sj_cd "$(command sj query $argv || return 1)"
    end
end

function ji
    _sj_cd $(command sj list | command grep -o '".*"' | command sed 's/"//g' | command fzf-tmux)
end
