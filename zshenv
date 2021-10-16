# GENERAL
export TERM="alacritty"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="firefox"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export XDG_BIN_HOME="$XDG_DATA_HOME/../bin"
export XDG_DESKTOP_DIR="/dev/null"
export XDG_DOWNLOADS_DIR="$HOME/downloads"

# shell
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_DATA_HOME/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

# cargo
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# X11
export XAUTHORITY="$XDG_CACHE_HOME/.Xauthority"
export XINITRC="$XDG_CONFIG_HOME/xorg/xinitrc"

# git
export GIT_REVIEW_BASE="main"
export GIT_PAGER="bat"

# nodejs
export npm_config_prefix="$XDG_DATA_HOME/npm"

# GO
export GOPATH="$XDG_DATA_HOME/go"

# PATH
#typeset _BIN_LOCAL="$(find "$HOME/.local/bin" -maxdepth 1 -type d -not -name '_*' -printf '%p:' | uniq)"
typeset _BIN_USER="$HOME/.local/bin/user_scripts/bin:$HOME/.local/bin"
typeset _BIN_CARGO="$CARGO_HOME/bin"
typeset _BIN_NPM="$npm_config_prefix/bin"

# This is not ideal. _BIN_LOCAL's find call concats an additional
# colon at the end of the path list, therefore, we have to omit
# it in the following export statement to avoid adding invalid/empty 
# dirs in the PATH
# TODO: Add local binary dirs manually. At this scale, globing is barley 
# sensible and doesn't improve readability
export PATH="$_BIN_USER:$_BIN_NPM:$_BIN_CARGO:$PATH"
unset _BIN_CARGO _BIN_LOCAL _BIN_NPM _BIN_USER

# OTHER
export PROXYCHAINS_CONF_FILE="$XDG_CONFIG_HOME/proxychains/proxychains.conf"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export WINEPREFIX="$XDG_DATA_HOME/wine/pfx/default"

export LESSHISTFILE="$XDG_DATA_HOME/lesshst"
export LESSHISTSIZE=100

export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# Fixing "bugs" in dwm...
export _JAVA_AWT_WM_NONREPARENTING=1

# Personal exports for script mangement... AHHHAH
export USER_DOTFILES="$HOME/dotfiles"
export USER_LIB_DIR="$HOME/.local/bin/user_scripts/lib"

