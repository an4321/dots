# Brave
```fish
# arch
i brave-bin
# debian
curl -fsS "https://dl.brave.com/install.sh" | sh

begin
	echo '#!/bin/env sh'
	echo 'brave-browser --force-device-scale-factor=1.2 $@'
end >"$HOME/.local/bin/brave" && chmod +x "$HOME/.local/bin/brave"
```
