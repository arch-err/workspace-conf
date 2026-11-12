if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
else
    __prompt_git() {
        local branch
        branch="$(git symbolic-ref --short HEAD 2>/dev/null)" || return 0
        local status=""
        git diff --quiet 2>/dev/null || status="*"
        git diff --cached --quiet 2>/dev/null || status="${status}+"
        printf ' (%s%s)' "$branch" "$status"
    }

    __prompt_exit() {
        local ec=$?
        if (( ec != 0 )); then
            printf ' [%d]' "$ec"
        fi
    }

    # Capture the command status before Git runs; keep Readline escapes in PS1.
    PS1='\[\e[1;34m\]\w\[\e[0m\]\[\e[31m\]$(__prompt_exit)\[\e[0m\]$(__prompt_git) \$ '
fi
