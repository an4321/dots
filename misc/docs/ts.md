# get node

```fish
set url "https://nodejs.org"
set latest (command curl $url"/dist/latest/" \
	| command grep -o '"[^"]*"' | cut -d '"' -f 2 \
	| command grep "linux-x64.tar.gz")

command wget $url$latest

set name (basename $latest)
command extract $name
command rm -rf $name

set old (ls $HOME/.local | grep node)
test -n $old && command rm -rf $HOME/.local/$old

command mv node* "$HOME/.local/"
set file (command ls -d $HOME/.local/node*)
set bins (command ls $file"/bin")
for i in $bins
	command ln -svf $file"/bin/"$i "$HOME/.local/bin/$i"
end
```


# get bun

```fish
command npm install -g bun
```
