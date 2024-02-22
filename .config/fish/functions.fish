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


function bak --argument filename
    cp $filename $filename.bak
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


function cd --description "ls and active on cd"
    if [ -n $argv[1] ]
        builtin cd $argv[1]
        ls

        # Broken for the fish prompt 🤧
        if test -f "env/bin/activate"
            source ./env/bin/activate.fish
        end
    end
end


function j
    echo -e "\e[1;31m\n$(zoxide query $argv)\e[0m"
    cd (zoxide query $argv)
end


function gc --description "Git Clone Copied URL"
    set clipboard (xclip -o)
    set dir_name (basename $clipboard '.git')
    git clone $clipboard && cd $dir_name
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


function ya
    set tmp (mktemp -t "yazi-cwd.XXXXX")
    yazi $argv --cwd-file="$tmp"

    builtin cd "$(cat $tmp)"
    rm -f "$tmp"
end


