set -gx fish_greeting
set -gx fish_cursor_insert line
fish_hybrid_key_bindings

source ~/.config/alias.sh
source ~/dots/bin/helper/jump-init.fish

function map
	bind -M insert $argv[1] $argv[2]
	bind -M default $argv[1] $argv[2]
end

bind H beginning-of-line
bind L end-of-line
map \cq exit
map \cH backward-kill-word
map \ck 'commandline -i $(history | fzf-tmux -h +s); commandline -f repaint'
map \ea 't menu; commandline -f repaint'
map \ee 'rbg kitty nvim'
map \ef 'rbg kitty lf'

# functions
function md; mkdir -p "$argv" && cd "$argv"; end
function cpg; cp $argv; and cd $argv[-1]; end
function mvg; mv $argv; and cd $argv[-1]; end
function c; echo "$argv" | sed 's/x/*/g' | bc -l; end

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
