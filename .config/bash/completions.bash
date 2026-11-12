__comp_cache="${XDG_CACHE_HOME:-$HOME/.cache}/bash/completions.cache"

# Source cache if available (instant)
[[ -f "$__comp_cache" ]] && source "$__comp_cache"

# Regenerate cache in background
(
    _out=""

    # Standard: <cmd> completion bash
    for cmd in kubectl helm docker podman argocd oc harbor; do
        command -v "$cmd" &>/dev/null && _out+="$("$cmd" completion bash 2>/dev/null)"$'\n'
    done

    # Special cases
    command -v gh &>/dev/null && _out+="$(gh completion -s bash 2>/dev/null)"$'\n'
    command -v npm &>/dev/null && _out+="$(npm completion 2>/dev/null)"$'\n'
    command -v pip &>/dev/null && _out+="$(pip completion --bash 2>/dev/null)"$'\n'
    command -v rustup &>/dev/null && _out+="$(rustup completions bash 2>/dev/null)"$'\n'
    command -v cargo &>/dev/null && command -v rustup &>/dev/null && _out+="$(rustup completions bash cargo 2>/dev/null)"$'\n'
    command -v uv &>/dev/null && _out+="$(uv generate-shell-completion bash 2>/dev/null)"$'\n'
    command -v uvx &>/dev/null && _out+="$(uvx --generate-shell-completion bash 2>/dev/null)"$'\n'
    command -v terraform &>/dev/null && _out+="complete -C terraform terraform"$'\n'

    mkdir -p "$(dirname "$__comp_cache")"
    # Concurrent tmux panes must not share a temporary output file.
    _tmp=$(mktemp "${__comp_cache}.XXXXXX") || exit
    trap 'rm -f -- "$_tmp"' EXIT
    printf '%s' "$_out" > "$_tmp"
    mv -- "$_tmp" "$__comp_cache"
) &
disown

# First run: no cache yet, source it once background job finishes
if [[ ! -f "$__comp_cache" ]]; then
    __comp_deferred() {
        if [[ -f "$__comp_cache" ]]; then
            source "$__comp_cache"
            local __hook
            local -a __remaining=()
            for __hook in "${PROMPT_COMMAND[@]}"; do
                [[ $__hook == __comp_deferred ]] || __remaining+=("$__hook")
            done
            PROMPT_COMMAND=("${__remaining[@]}")
            unset -f __comp_deferred
        fi
        return 0
    }
    # Starship and other integrations can register multiple prompt hooks.
    if [[ $(declare -p PROMPT_COMMAND 2>/dev/null) != 'declare -a '* ]]; then
        PROMPT_COMMAND=("${PROMPT_COMMAND:-}")
    fi
    PROMPT_COMMAND=(__comp_deferred "${PROMPT_COMMAND[@]}")
fi

# urfave/cli tools (cheap — no subprocess, loaded synchronously)
__comp_urfave=(tea drone)
for __comp_cmd in "${__comp_urfave[@]}"; do
    if command -v "$__comp_cmd" &>/dev/null; then
        eval "_${__comp_cmd}_bash_autocomplete() {
            local cur opts
            COMPREPLY=()
            cur=\"\${COMP_WORDS[COMP_CWORD]}\"
            opts=\$( \"\${COMP_WORDS[@]:0:\$COMP_CWORD}\" --generate-bash-completion 2>/dev/null )
            COMPREPLY=( \$(compgen -W \"\${opts}\" -- \"\${cur}\") )
        }"
        complete -o default -F "_${__comp_cmd}_bash_autocomplete" "$__comp_cmd"
    fi
done
unset __comp_cmd __comp_urfave
