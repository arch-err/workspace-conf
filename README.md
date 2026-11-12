# workspace-conf

Bash, tmux, Neovim, Readline, and Starship configuration for toolbox.
Bash is based on [bash-conf](https://github.com/arch-err/bash-conf), with its
modules under `.config/bash/` and a `~/.bashrc` shim.

Clone into your persistent home, then run:

```sh
./install.sh
exec bash
```

The installer links the configs and backs up existing files under
`~/.local/state/workspace-conf/backup.*`. Rerunning it preserves correct links.
Keep the clone in place; the links point into it.

After pulling changes, open a new shell. In tmux, Ctrl-B then r reloads
its configuration. Starship is used when installed in the toolbox image.
Its single-line prompt uses Nerd Font symbols.

tmux and Neovim follow the host configuration. Resurrect and Continuum are
included locally, with their licenses. Clipboard copying uses Wayland when
available and OSC 52 remotely; the client terminal must support it. Terminal
paste shortcuts work independently of OSC 52 clipboard-read support.
Git uses delta for paged diffs and interactive patch highlighting.

Ctrl-R searches history through fzf. Git, Kubernetes, Helm, and Podman
abbreviations expand on Space or Enter; Docker stays in `abbr/unused/`.
The abbreviation engine is vendored with its MIT license from
[bash-abbrev-alias](https://github.com/momo-lab/bash-abbrev-alias/tree/6afb671fc95b3c559f2665637df65d9060f4d320),
so the internal Git mirror needs no submodule download.
