# This configuration has been partially inspired by this guide:
# https://thevaluable.dev/zsh-install-configure-mouseless/

# =======
# Options
# =======

# Enable debugging
zmodload zsh/zprof

# Navigation and jumping around
setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

# History
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

# =======
# General
# =======

# Add my plugins to the functions path
fpath=($ZDOTDIR/functions $fpath)

# Relocate ZSH completion cache
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Enable Vi mode
KEYTIMEOUT=1; bindkey -v

# Edit command line with $EDITOR
autoload -Uz edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# "Bug fixing"/Convenience
stty -ixon # Disable flow control

# ==========
# "Userland"
# ==========

# Batch renaming function
autoload -Uz zmv

# Override colors for gnu applications
eval "$(dircolors -b $ZDOTDIR/plugins/dircolors)" 

source $ZDOTDIR/config/completion.zsh
source $ZDOTDIR/config/aliases.zsh
source $ZDOTDIR/config/scripts.zsh

autoload -U setup_prompt; setup_prompt
autoload -U setup_cursor_mode; setup_cursor_mode

# ==========================
# External tools and plugins
# ==========================

# zoxide:   Jump to directories. Probably my favorite and most used
#           tool for the shell
# Source:   https://github.com/ajeetdsouza/zoxide
if command -v 'zoxide' > /dev/null; then
  eval "$(zoxide init zsh)"
fi

# fzf:      A very useful and universal cli fuzzy finder
#           TODO: ReWRite It iN rUsT!1!
# Source:   https://github.com/junegunn/fzf
if command -v "fzf" > /dev/null; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
fi

# External zsh plugins

# znotify:  Something that I'm working on. Probably already exists in a much more useful
#           manner, but it was fun to create non the less and a great learning exercise.
#           Source: TODO

#           Neat auto completions!
# Source:   https://github.com/zsh-users/zsh-autosuggestions
source $ZDOTDIR/extern/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

#           Very pretty syntax highlighting.
# Source:   https://github.com/zsh-users/zsh-syntax-highlighting
# Note:     To be sourced at the end of the config or after every call to zle that
#           registers a new hook or widget.
source $ZDOTDIR/extern/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Output profiler log
zprof
