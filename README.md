# workspace-conf

Bash, tmux, Neovim, Readline, and Starship configuration for toolbox.
Bash is based on [bash-conf](https://github.com/arch-err/bash-conf), with its
modules under `.config/bash/` and a `~/.bashrc` shim.

Clone into your persistent home and symlink the files you want to use.
Move existing configs aside first. For example, from this checkout:

```sh
ln -s "$PWD/.bashrc" ~/.bashrc
ln -s "$PWD/.tmux.conf" ~/.tmux.conf
mkdir -p ~/.config
ln -s "$PWD/.config/bash" ~/.config/bash
ln -s "$PWD/.config/nvim" ~/.config/nvim
ln -s "$PWD/.config/starship.toml" ~/.config/starship.toml
```

After pulling changes, open a new shell. In tmux, Ctrl-B then Shift-R reloads
its configuration. Starship is used when installed in the toolbox image.
Its single-line prompt uses Nerd Font symbols.

Ctrl-R searches history through fzf. Git, Kubernetes, Helm, and Podman
abbreviations expand on Space or Enter; Docker stays in `abbr/unused/`.
The abbreviation engine is vendored with its MIT license from
[bash-abbrev-alias](https://github.com/momo-lab/bash-abbrev-alias/tree/6afb671fc95b3c559f2665637df65d9060f4d320),
so the internal Git mirror needs no submodule download.
