# Fuzzy history search (Ctrl-R)
unset FZF_CTRL_R_COMMAND
if command -v fzf &>/dev/null; then
    export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS }--reverse"
    # fzf ≥0.48 ships keybindings as a subcommand
    if fzf --bash &>/dev/null 2>&1; then
        eval "$(fzf --bash)"
    else
        for __fzf_kb in \
            /usr/share/fzf/key-bindings.bash \
            /usr/share/doc/fzf/examples/key-bindings.bash \
            /etc/bash_completion.d/fzf \
            /nix/store/*-fzf-*/share/fzf/key-bindings.bash; do
            [[ -f "$__fzf_kb" ]] && source "$__fzf_kb" && break
        done
        unset __fzf_kb
    fi
fi

# XDG-compliant history file
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/bash/history"
mkdir -p "$(dirname "$HISTFILE")"

# Size
HISTSIZE=50000
HISTFILESIZE=100000

# Behavior
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:cd:pwd:exit:clear:history"
HISTTIMEFORMAT="%F %T  "

shopt -s histappend
