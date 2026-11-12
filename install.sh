#!/usr/bin/env bash
set -euo pipefail

repo=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
config_home=${XDG_CONFIG_HOME:-$HOME/.config}
state_home=${XDG_STATE_HOME:-$HOME/.local/state}
backup=''

link_config() {
    local source=$1 target=$2 relative=$3
    if [[ -L $target && $(readlink -- "$target") == "$source" ]]; then
        return
    fi

    mkdir -p -- "$(dirname -- "$target")"
    if [[ -e $target || -L $target ]]; then
        if [[ -z $backup ]]; then
            mkdir -p -- "$state_home/workspace-conf"
            backup=$(mktemp -d "$state_home/workspace-conf/backup.XXXXXX")
        fi
        mkdir -p -- "$backup/$(dirname -- "$relative")"
        mv -- "$target" "$backup/$relative"
    fi

    ln -s -- "$source" "$target"
    printf 'Linked %s\n' "$target"
}

for file in .bashrc .tmux.conf; do
    link_config "$repo/$file" "$HOME/$file" "$file"
done

for file in bash tmux nvim git starship.toml; do
    link_config "$repo/.config/$file" "$config_home/$file" ".config/$file"
done

if [[ -n $backup ]]; then
    printf 'Previous configs backed up to: %s\n' "$backup"
fi
printf 'Open a new Bash shell or run: exec bash\n'
printf 'To reload a running tmux server: tmux source-file ~/.tmux.conf\n'
