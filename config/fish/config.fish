set -gx fish_greeting
fish_hybrid_key_bindings
fish_add_path ~/.local/bin ~/dots/bin ~/go/bin ~/.local/node/bin ~/.local/share/pnpm/bin
set -gx LC_ALL en_US.UTF-8
set -gx EDITOR nvim
set -gx MANPAGER "nvim +Man!"
set -gx FZF_DEFAULT_OPTS "--cycle --reverse --no-separator --scroll-off=3 --prompt ' > ' --pointer ' ' --marker='* ' -m --color=bg+:yellow,hl+:0,prompt:yellow,fg+:black,gutter:-1,border:yellow --bind='ctrl-space:toggle-preview,ctrl-h:backward-kill-word,ctrl-bs:backward-kill-word,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-o:execute(xdg-open {} >/dev/null 2>&1 &)'"
set -gx IGNORE "node_modules,.next,.svelte-kit,__pycache__,.venv,.cache,.bun,.npm,.local/share"

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
