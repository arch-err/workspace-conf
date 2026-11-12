# shellcheck shell=bash
case $- in
    *i*) ;;
    *) return ;;
esac

shopt -s checkwinsize histappend
HISTCONTROL=ignoreboth
HISTSIZE=50000
HISTFILESIZE=100000
export EDITOR=nvim VISUAL=nvim

# Newer toolbox images initialize these globally; older images use this fallback.
if [[ ${_TOOLBOX_SHELL_INITIALIZED:-} != 1 && ${_WORKSPACE_CONF_SHELL_INITIALIZED:-} != 1 ]]; then
    _WORKSPACE_CONF_SHELL_INITIALIZED=1
    if [[ -r /usr/share/bash-completion/bash_completion ]]; then
        source /usr/share/bash-completion/bash_completion
    fi
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
    export FZF_DEFAULT_OPTS='--height=50% --layout=reverse --border'
    export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 -- {}'"
    # Atuin owns Ctrl-R; fzf supplies Ctrl-T and Alt-C.
    export FZF_CTRL_R_COMMAND=''
    command -v fzf >/dev/null && eval "$(fzf --bash)"
    command -v direnv >/dev/null && eval "$(direnv hook bash)"
    command -v zoxide >/dev/null && eval "$(zoxide init bash)"
    command -v atuin >/dev/null && eval "$(atuin init bash)"
    if command -v starship >/dev/null; then
        export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml"
        eval "$(starship init bash)"
    fi
fi
