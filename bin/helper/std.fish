set RED "\e[31m"
set BLUE "\e[34m"
set GREEN "\e[32m"
set YELLOW "\e[33m"
set BOLD "\e[1m"
set UNDERLINE "\e[4m"
set INVERT "\e[7m"
set RESET "\e[0m"

function die
	printf "$RED%s$RESET %s\n" "error:" "$argv" >&2 && exit 1
end

function warn
	printf "$YELLOW%s$RESET %s\n" "warning:" "$argv" >&2 && return 1
end

function success
	echo -e $GREEN$BOLD"$argv"$RESET
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
			warn "checkcmd needs at least 1 argument"
		case 1
			command -v $argv &>/dev/null
		case "*"
			for c in $argv
				command -v $c &>/dev/null || warn "'$c' command not found"
			end
	end
end
