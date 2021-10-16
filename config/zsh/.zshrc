# This file has been inspired by this gude:
# https://thevaluable.dev/zsh-install-configure-mouseless/

# TODO: Currently, this doesn't have any real use...
# DO SOMETHING
fpath=($ZDOTDIR/functions $fpath)

# NAV
setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

# HISTORY
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

# relocate zcompdump
autoload -U compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Enable Vi mode
bindkey -v
export KEYTIMEOUT=1

# edit command line with $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# "USERLAND"
eval "$(dircolors -b $ZDOTDIR/plugins/dircolors)" # Override colors

source $ZDOTDIR/config/completion.zsh
source $ZDOTDIR/config/aliases.zsh
source $ZDOTDIR/config/scripts.zsh
source $ZDOTDIR/config/prompt.zsh
source $ZDOTDIR/config/cursor_mode.zsh # Change cursor on modechange

# "Bug fixing"/Convenience
stty -ixon # Disable flow control

# External tools used in the shell

# zoxide
if [ $(command -v 'zoxide') ]; then
  eval "$(zoxide init zsh)"
fi

# fzf
if [ $(command -v "fzf") ]; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
fi

# External zsh plugins

# Awesome plugin! Source: https://github.com/zsh-users/zsh-syntax-highlighting
# To be sourced at the end of the config!
source $ZDOTDIR/extern/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

