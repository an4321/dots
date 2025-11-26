set -gx fish_greeting
set -gx fish_cursor_insert line
fish_hybrid_key_bindings

source ~/.config/fish/alias.sh
source ~/dots/misc/jump/init.fish

bind H beginning-of-line
bind L end-of-line

function map; for i in insert default; bind -M $i $argv; end; end
map \cq exit
map \cH backward-kill-word
map \ck 'commandline -i $(history | fzf-tmux -h +s); commandline -f repaint'
map \ea 't menu; commandline -f repaint'

# functions
function md; mkdir -p "$argv" && j "$argv"; end
function cpg; cp $argv && j $argv[-1]; end
function mvg; mv $argv && j $argv[-1]; end
function c; echo "$argv" | sed 's/x/*/g' | bc -l; end
function y; test -n "$WAYLAND_DISPLAY" && wl-copy || xsel -b; end
function p; test -n "$WAYLAND_DISPLAY" && wl-paste || xsel -bo; end
function yy; history --max=1 | tr -d '\n' | y; end

# bang bang
function __history_previous_command
	switch (commandline -t)
		case "!"
			commandline -t $history[1]
			commandline -f repaint
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
if test "$fish_key_bindings" = fish_vi_key_bindings -o "$fish_key_bindings" = fish_hybrid_key_bindings
	bind --mode insert ! __history_previous_command
	bind --mode insert '$' __history_previous_command_arguments
end
