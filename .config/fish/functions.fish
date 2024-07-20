# Functions Island

# set up the same key bindings for insert mode if using fish_vi_key_bindings
if test "$fish_key_bindings" = 'fish_vi_key_bindings'
    bind --mode insert ! __history_previous_command
    bind --mode insert '$' __history_previous_command_arguments
end


# BANG BANG!!
function __history_previous_command
    switch (commandline -t)
    case "!"
        commandline -t $history[1]; commandline -f repaint
    case "*"
        commandline -i !
    end
end

bind ! __history_previous_command
bind '$' __history_previous_command_arguments

function __history_previous_command_arguments
    switch (commandline -t)
    case "!"
        commandline -t ""
        commandline -f history-token-search-backward
    case "*"
        commandline -i '$'
    end
end

function _plugin-bang-bang_uninstall --on-event plugin-bang-bang_uninstall
    bind --erase --all !
    bind --erase --all '$'
    functions --erase _plugin-bang-bang_uninstall
end


function md -d "Create a directory and set CWD"
    command mkdir -p $argv
    if test $status = 0
        switch $argv[(count $argv)]
        case '-*'

        case '*'
            cd $argv[(count $argv)]
            return
        end
    end
end


function cd --description "ls on cd"
    if [ -n $argv[1] ]
        builtin cd $argv[1]
        ls
    end
end


function j
    if test (count $argv) -eq 0
        echo -e "\e[1;31m\nDesktop\e[0m"
        cd ~/Desktop
    else
        set result (zoxide query $argv)

        if test $status -eq 0
            echo -e "\e[1;31m\n$result\e[0m"
            cd $result
        end
    end
end


function cpg
    if test -d "$argv[2]" 
        cp "$argv[1]" "$argv[2]"
        and cd "$argv[2]"
    else 
        cp "$argv[1]" "$argv[2]"
    end
end


function mvg
    if test -d "$argv[2]"
        mv "$argv[1]" "$argv[2]"
        and cd "$argv[2]"
    else
        mv "$argv[1]" "$argv[2]"
    end
end

