# Link my config. like totaly automatic and such.

source "$DOTFILES_ROOT/lib/log.sh"

DOTFILES_CONFIG="$(readlink -f "${SCRIPT_DIR:?Missing script root}/config")"

TARGET_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
TARGET_HOME="$HOME"

typeset -a paths=(
    "$DOTFILES_CONFIG/alacritty"    "$TARGET_CONFIG/alacritty"
    "$DOTFILES_CONFIG/gdb"          "$TARGET_CONFIG/gdb"
    "$DOTFILES_CONFIG/ncspot"       "$TARGET_CONFIG/ncspot"
    "$DOTFILES_CONFIG/nvim"         "$TARGET_CONFIG/nvim"
    "$DOTFILES_CONFIG/river"        "$TARGET_CONFIG/river"
    "$DOTFILES_CONFIG/rizin"        "$TARGET_CONFIG/rizin"
    "$DOTFILES_CONFIG/zathura"      "$TARGET_CONFIG/zathura"
    "$DOTFILES_CONFIG/zsh"          "$TARGET_CONFIG/zsh"

    "$DOTFILES_CONFIG/clang-format"   "$TARGET_HOME/.clang-format"
    "$DOTFILES_CONFIG/tmux/tmux.conf" "$TARGET_HOME/.tmux.conf"
    "$DOTFILES_CONFIG/zsh/zshenv"     "$TARGET_HOME/.zshenv"
)

link() {
    if ln -s "$1" "$2" 2>/dev/null; then
        log_info "Linking '$src' to '$target'"
    else
        log_error "Failed to link '$1' to '$2'"
    fi
}

create_directory() {
    if [[ -x $1 ]]; then
        log_warn "Directory exists: $1"
    else
        log_info "Creating directory $@"
        mkdir -p "$@"
    fi
}

create_directory "$TARGET_HOME"
create_directory "$TARGET_CONFIG"

typeset -i count=1
for _ in ${(u)paths}
do
    if [[ $((count & 1)) -eq 0 ]]; then
        local target="$paths[$count]"
        local src="$paths[$(( $count - 1))]"

        if [[ -e $target ]]; then
            log_warn "Skipping path: exists: $target"
        else
            link "$src" "$target"
        fi
    fi

    count="$(($count + 1))"
done


