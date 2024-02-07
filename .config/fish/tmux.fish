
function t --description "Jump to Tmux"
    set target_dir (zoxide query $argv[1])
    
    if test -d "$target_dir"
        if set -q TMUX
            tmux new -ds (basename $target_dir) -c $target_dir
            tmux switch-client -t (basename $target_dir)
        else
            tmux new -s (basename $target_dir) -c $target_dir
        end
    else
        echo "Error: Not a valid directory."
    end
end

function tmux_attach
    set sessions (tmux ls | grep -o '^[^:]*')

    if ! set -q TMUX
        if test (count $sessions) -eq 1
            tmux attach
        else if test (count $sessions) -eq 0
            tmux new-session -s Main
        else
            echo -e "\n\n\e[1m\e[34mTmux Sessions:\e[0m"

            set selected_session (gum choose --selected="Clone" --cursor=" " $sessions)
            set selected_session (string split ":" $selected_session)[1]

            tmux attach -t $selected_session
        end
    end
end

bind \ea 'tmux_attach; commandline -f repaint'

