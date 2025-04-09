# General
set -x EDITOR "nvim"
set -x VISUAL "$EDITOR"
set -x BROWSER "firefox-developer-edition"

# Being explicit about the defaults...
# See: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# A bit more comprehensible: https://wiki.archlinux.org/title/XDG_Base_Directory
set -x XDG_CACHE_HOME "$HOME/.cache"
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_STATE_HOME "$HOME/.local/state"
set -x XDG_BIN_HOME "$HOME/.local/bin"

# Cargo/Rust
set -x RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -x CARGO_HOME "$XDG_DATA_HOME/cargo"

# Git
set -x GIT_REVIEW_BASE "main"
set -x GIT_PAGER "bat"

# NodeJS - npm global modules/config
set -x npm_config_prefix "$XDG_DATA_HOME/npm"

# DenoJS
set -x DENO_DIR "$XDG_CACHE_HOME/deno"
set -x DENO_INSTALL_ROOT "$XDG_DATA_HOME/deno/bin"

# Go
set -x GOPATH "$XDG_DATA_HOME/go"

# Other
set -x PROXYCHAINS_CONF_FILE "$XDG_CONFIG_HOME/proxychains/proxychains.conf"
set -x PASSWORD_STORE_DIR "$XDG_DATA_HOME/pass"
set -x WINEPREFIX "$XDG_DATA_HOME/wine/pfx/default"

set -x LESSHISTFILE "$XDG_DATA_HOME/lesshist"
set -x LESSHISTSIZE 100
set -x LESSKEYIN_SYSTEM "$XDG_CONFIG_HOME/lesskey"

# Pager for man with some color changes
set -x MANPAGER 'less -R --use-color -Dur$Dd+c$Dsy$DPw$DSw'
set -x MANROFFOPT '-c'

# GNU GPG
set -x GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -x GPG_TTY "$(tty)"

# GNU GDB
set -x GDBHISTORYPATH "$XDG_CACHE_HOME/gdb/gdbhist"

# PATH
fish_add_path "$HOME/.local/bin"
fish_add_path "$CARGO_HOME/bin"
fish_add_path "$npm_config_prefix/bin"
fish_add_path "$HOME/.bun/bin"

# Personal exports for script mangement... AHHHAH
set -x DOTFILES_ROOT "$HOME/dotfiles"
set -x DISK_ONE "/mnt/data_0"

fish_add_path "$DOTFILES_ROOT/bin"
