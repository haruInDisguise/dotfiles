#!/usr/bin/zsh

# Link my config. like totaly automatic and such.

SCRIPT_DIR="$(dirname $PWD/$0)"

DOTFILES_ROOT="$(readlink -f $SCRIPT_DIR/..)"
DOTFILES_CONFIG="$DOTFILES_ROOT/config"
TARGET_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
TARGET_HOME="$HOME"

typeset -a paths=(
    "$DOTFILES_CONFIG/nvim" "$TARGET_CONFIG/nvim"
    "$DOTFILES_CONFIG/zsh" "$TARGET_CONFIG/zsh"
    "$DOTFILES_CONFIG/alacritty" "$TARGET_CONFIG/alacritty"

    "$DOTFILES_CONFIG/tmux/tmux.conf" "$TARGET_HOME/.tmux.conf"
    "$DOTFILES_CONFIG/xorg/xinitrc" "$TARGET_HOME/.xinitrc"
    "$DOTFILES_CONFIG/zsh/zshenv" "$TARGET_HOME/.zshenv"
)

_log_fmt() { print -- "\x1b[30m$(date -u '+%Y-%m-%dT%H:%m:%SZ')\x1b[0m [$1] - $argv[2,-1]"; }
log_info() { _log_fmt $'\x1b[32m'"INFO "$'\x1b[0m' $@; }
log_error() { _log_fmt $'\x1b[31m'"ERROR"$'\x1b[0m' $@; }
log_warn() { _log_fmt $'\x1b[33m'"WARN "$'\x1b[0m' $@; }

link() {
    ln -s "$1" "$2"
}

create_directory() {
    if [[ -x $1 ]]; then
        log_error "Directory exists: $1"
    else
        log_info "Creating directory $@"
        mkdir -p "$@"
    fi
}

create_directory $TARGET_CONFIG
create_directory $TARGET_HOME

local count=1
for _ in ${(u)paths}
do
    local target="$paths[$count]"
    local src="$paths[$(( $count - 1))]"

    if [[ $(( count & 1 )) -eq 0 ]]; then
        if [[ -e $target ]]; then
            log_warn "Skipping path: exists: $target"
        else
            link "$src" "$target"
            log_info "linking '$src' to '$target'"
        fi
    fi

    count="$(($count + 1))"
done


