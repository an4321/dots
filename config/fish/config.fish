set -gx fish_greeting
set -gx fish_cursor_insert line
fish_hybrid_key_bindings

source ~/.config/fish/alias.sh
source ~/dots/misc/jump/init.fish

bind H beginning-of-line
bind L end-of-line
bind -M insert \cq exit
bind -M insert \cH backward-kill-word

# functions
function c; echo "$argv" | sed 's/x/*/g' | bc -l; end
function y; test -n "$WAYLAND_DISPLAY" && wl-copy || xsel -b; end
function p; test -n "$WAYLAND_DISPLAY" && wl-paste || xsel -bo; end
function yy; history --max=1 | tr -d '\n' | y; end
function hist; commandline -i $(history | fzf); end

# bang bang
function __history_previous_command
	switch (commandline -t)
		case "!"; commandline -t $history[1] && commandline -f repaint
		case "*"; commandline -i !
	end
end
function __history_previous_command_arguments
	switch (commandline -t)
		case "!"; commandline -t "" && commandline -f history-token-search-backward
		case "*"; commandline -i '$'
	end
end
bind --mode insert ! __history_previous_command
bind --mode insert '$' __history_previous_command_arguments
