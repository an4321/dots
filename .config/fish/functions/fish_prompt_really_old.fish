function fish_prompt
    if test -n "$SSH_TTY"
        echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
    end

    echo
    echo -n (set_color -o 55B6C2)(prompt_pwd)' '

    if test "$PWD" != "$HOME"
        echo
    end

    # echo -n (set_color red)''(set_color yellow)''(set_color green)' '
    echo -n (set_color 98C379)' '
    # echo -n (set_color 3ac7b0)' '
    set_color normal
end
