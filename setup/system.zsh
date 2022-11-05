# Install configurations on system level (i.e. /etc/*)

source "$DOTFILES_ROOT/lib/log.sh"

DOTFILES_SYSTEM="$(readlink -f "${SCRIPT_DIR:?Missing script root}")/system"

# NOTE:
# - Directories must be mapped to directories (if the target
#   already exists, the sources contents will be copied recursively)
# - Files must map to files (missing directories will be created)
typeset -a paths=(
    "$DOTFILES_SYSTEM/pacman/hooks" "/etc/pacman.d/hooks"
)

copy() {
    local src="$argv[0,$(( ${#argv} - 1 ))]"
    local target="$argv[-1]"

    log_warn "Attempting to run as root"
    if sudo cp -rL $src "$target" &>/dev/null; then
        log_info "Copying '$src' to '$target'"
    else
        log_error "Failed to copy '$1' to '$2'"
    fi
}

create_directory() {
    if [[ -x $1 ]]; then
        log_warn "Directory exists: $1"
    else
        log_info "Creating directory $@"
        sudo mkdir -p "$@"
    fi
}

typeset -i count=1
for _ in ${(u)paths}; do
    if [[ "$((count & 1))" -eq 0 ]]; then
        local src="$paths[$((count - 1))]"
        local target="$paths[$count]"

        if [[ -d "$src" ]]; then
            if [[ ! -d "$target" ]]; then
                create_directory "$target"
            fi

            copy "$src"/* "$target"
        else
            if [[ -d "$target" ]]; then
                log_error "Failed to copy '$src': '$target' is a directory"
            else
                local parent_dir="$(dirname $target)"
                [[ ! -d "$parent_dir" ]] && create_directory "$parent_dir"
                copy "$src" "$target"
            fi
        fi
    fi

    count="$((count + 1))"
done
