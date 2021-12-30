#!/usr/bin/zsh

# Symlink config into the correct locations...
DIR_SCRIPT="$(dirname $(readlink -f $0 ) )"

TARGET_ROOT="$HOME"
TARGET_CONFIG="$XDG_CONFIG_HOME"
DIR_CONFIG="$DIR_SCRIPT/config"
DIR_ROOT="$DIR_SCRIPT"

LINK_CMD="command -p ln -sf"

typeset -a links_config=(
    "$DIR_CONFIG/zsh"         "$TARGET_CONFIG/zsh"
    "$DIR_CONFIG/nvim"        "$TARGET_CONFIG/nvim"
    "$DIR_CONFIG/alacritty"   "$TARGET_CONFIG/alacritty"
    "$DIR_CONFIG/neofetch"    "$TARGET_CONFIG/neofetch"

    "$DIR_ROOT/xinitrc"          "$TARGET_ROOT/.xinitrc"
    "$DIR_CONFIG/zsh/zshenv"     "$TARGET_ROOT/.zshenv"
    "$DIR_CONFIG/tmux/tmux.conf" "$TARGET_ROOT/.tmux.conf"

)

main() {
    for path link_name in $links_config; do
        print -- $path $link_name
        eval "$LINK_CMD $path $link_name"
    done
}

main $@
