# BANG BANG!!
function __history_previous_command
    switch (commandline -t)
    case "!"
        commandline -t $history[1]; commandline -f repaint
    case "*"
        commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
    case "!"
        commandline -t ""
        commandline -f history-token-search-backward
    case "*"
        commandline -i '$'
    end
end

bind ! __history_previous_command
bind '$' __history_previous_command_arguments

# set up the same key bindings for insert mode if using fish_vi_key_bindings
if test "$fish_key_bindings" = 'fish_vi_key_bindings' -o "$fish_key_bindings" = 'fish_hybrid_key_bindings'
    bind --mode insert ! __history_previous_command
    bind --mode insert '$' __history_previous_command_arguments
end


function md -d "Create a directory and set CWD"
	mkdir -p "$argv" && cd "$argv"
end

function j
    if test (count $argv) -eq 0
        cd ~/Desktop
    else
        set result (zoxide query $argv)

        if test $status -eq 0
            cd $result
        end
    end
end

function cpg
    cp $argv; and cd $argv[-1]
end

function mvg
    mv $argv; and cd $argv[-1]
end

function y -d "copy to clipboard"
    if test -n "$WAYLAND_DISPLAY"
        wl-copy
    else
        xsel --clipboard
    end
end
 
function p -d "paste from clipboard"
    if test -n "$WAYLAND_DISPLAY"
        wl-paste
    else
        xsel --clipboard --output
    end
end

function cat
    if command -v bat &> /dev/null
        bat -p --theme=OneHalfDark --color always $argv
    else if command -v batcat &> /dev/null
        batcat -p --theme=OneHalfDark --color always $argv
    else
        command cat $argv
    end
end

