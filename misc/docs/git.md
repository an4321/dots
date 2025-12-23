# setup git

```fish
git config --global user.name ""
git config --global user.email ""

# generate ssh key pair if you haven't already
ssh-keygen -t ed25519 -C "$email"

# add ssh key to agent
bash -c "$(ssh-agent -s)"
ssh-add "$HOME/.ssh/id_ed25519"
```


# github setup

* add the public key to github:
  1. go to github settings
  2. in the sidebar, click ssh and gpg keys
  3. click new ssh key or add ssh key
  4. paste this
    `cat "$HOME/.ssh/id_ed25519.pub"`
  5. test connection
    `ssh -T git@github.com`

* to set remote origin:
    `git remote set-url origin git@github.com:username/repository.git`
