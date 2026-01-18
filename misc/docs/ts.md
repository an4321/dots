# get node

```fish
set url "https://nodejs.org"
set latest (curl $url"/dist/latest/" \
	| grep -o '"[^"]*"' | cut -d '"' -f 2 \
	| grep "linux-x64.tar.gz")

wget $url$latest

set name (basename $latest)
extract $name
rm -rf $name

set old (ls $HOME/.local | grep node)
test -n $old && rm -rf $HOME/.local/$old

mv node* "$HOME/.local/"
set file (ls -d $HOME/.local/node*)
set bins (ls $file"/bin")
for i in $bins
	ln -svf $file"/bin/"$i "$HOME/.local/bin/$i"
end
```


# get bun

```fish
npm install -g bun
```
