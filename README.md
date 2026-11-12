# workspace-conf

Bash, tmux, Neovim, Readline, and Starship configuration for toolbox.

Clone into your persistent home and symlink the files you want to use.
Move existing configs aside first. For example, from this checkout:

```sh
ln -s "$PWD/.bashrc" ~/.bashrc
ln -s "$PWD/.inputrc" ~/.inputrc
ln -s "$PWD/.tmux.conf" ~/.tmux.conf
mkdir -p ~/.config
ln -s "$PWD/.config/nvim" ~/.config/nvim
ln -s "$PWD/.config/starship.toml" ~/.config/starship.toml
```

After pulling changes, open a new shell. In tmux, Ctrl-B then Shift-R reloads
its configuration. Starship is used when installed in the toolbox image.
