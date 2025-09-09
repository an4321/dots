function die
	# echo "error: $argv" >&2 && exit 1
	printf "$RED%s$RESET %s\n" "error:" "$argv" >&2 && exit 1
end

function warn
	# echo "warning: $argv" >&2 && return 1
	printf "$YELLOW%s$RESET %s\n" "warning:" "$argv" >&2 && return 1
end

function confirm
	read -P "$argv (y/N) " yn && string match -qr '^[Yy]$' $yn || return 1
end

function accept
	read -P "$argv (Y/n) " yn && string match -qr '^[Yy]?$' $yn || return 1
end

function checkcmd
	switch (count $argv)
		case 0
			die "checkcmd needs at least 1 argument"
		case 1
			command -v $argv &>/dev/null
		case "*"
			for c in $argv
				command -v $c &>/dev/null || warn "'$c' command not found"
			end
	end
end
