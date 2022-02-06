#!/usr/bin/zsh

# Symlink config into the correct locations...
DIR_SCRIPT="$(dirname $(readlink -f $0 ) )"

TARGET_ROOT="$HOME"
TARGET_CONFIG="$XDG_CONFIG_HOME"
DIR_CONFIG="$DIR_SCRIPT/config"
DIR_ROOT="$DIR_SCRIPT"

LINK_CMD="command -p ln -sf"

typeset -a links_config=(
    '$root_config/zsh'         '$target_config/zsh'
    '$root_config/nvim'        '$target_config/nvim'
    '$root_config/alacritty'   '$target_config/alacritty'
    '$root_config/neofetch'    '$target_config/neofetch'

    '$root_dir/xinitrc'          '$target_root/.xinitrc'
    '$root_config/zsh/zshenv'     '$target_root/.zshenv'
    '$root_config/tmux/tmux.conf' '$target_root/.tmux.conf'
)

link_for_user() {
    local root_dir="${}"
    local root_config="${}"
    local target_root="${}"
    local target_config="${}"

    local user="${3:-$LOGNAME}"
}

main() {
    for path link_name in $links_config; do
        print -- $path $link_name
        eval "$LINK_CMD $path $link_name"
    done
}

main $@
