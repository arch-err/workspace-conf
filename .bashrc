# shellcheck shell=bash
if [[ -r ${XDG_CONFIG_HOME:-$HOME/.config}/bash/bashrc ]]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}/bash/bashrc"
fi
