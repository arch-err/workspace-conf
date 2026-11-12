if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
else
    __prompt_git() {
        local branch
        branch="$(git symbolic-ref --short HEAD 2>/dev/null)" || return
        local status=""
        git diff --quiet 2>/dev/null || status="*"
        git diff --cached --quiet 2>/dev/null || status="${status}+"
        printf ' (%s%s)' "$branch" "$status"
    }

    __prompt_exit() {
        local ec=$?
        [[ $ec -ne 0 ]] && printf ' \[\e[31m\][%d]\[\e[0m\]' "$ec"
    }

    PS1='\[\e[1;34m\]\w\[\e[0m\]$(__prompt_git)$(__prompt_exit) \$ '
fi
