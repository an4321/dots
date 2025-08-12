function j() {
    if [[ $# -eq 0 ]]; then
        \builtin cd ~/Desktop
    elif [[ $# -eq 1 && $1 == '-' ]]; then
        \builtin cd "${OLDPWD}"
    elif [[ $# -eq 1 && -d $1 ]]; then
        \builtin cd "$1"
    else
        \builtin cd "$(\command sj query "$@")" 2>/dev/null || return 1
    fi
}

function ji() {
    \builtin cd "$(\command sj list | \command awk '{print $1}' | \command fzf-tmux)"
}

_sj_oldpwd="$(\builtin pwd -L)"

function _sj_hook() {
    local -r retval="$?"
    local pwd_tmp="$(\builtin pwd -L)"
    if [[ ${_sj_oldpwd} != "${pwd_tmp}" ]]; then
        _sj_oldpwd="${pwd_tmp}"
        \command sj add "${_sj_oldpwd}" >/dev/null
    fi
    return "${retval}"
}

# initialize hook
if [[ ${PROMPT_COMMAND:=} != *'_sj_hook'* ]]; then
    PROMPT_COMMAND="_sj_hook;${PROMPT_COMMAND#;}"
fi
