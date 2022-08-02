# =======
# Options
# =======

# Debug
if [[ -n "$DEBUG" ]]; then
    zmodload 'zsh/zprof'
    setopt SOURCE_TRACE
fi

# Docs on options:
# https://zsh.sourceforge.io/Doc/Release/Options.html

# Navigation and jumping around
setopt AUTO_CD              # Go to folder path without using cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt CHASELINKS           # Always resove symlinks in the path segment
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

# General
setopt HASH_CMDS

# Grammar
setopt CORRECT

# Jobs
setopt AUTO_CONTINUE            # Disowned jobs are automatically continued
setopt CHECK_JOBS               # Check for suspended jobs on exit (default in bash)
setopt CHECK_RUNNING_JOBS       # Check for running and suspended jobs on exit
setopt HUP                      # Send the HUP singnal to running jobs, when the shell exits

# History

# The 'share_history' option automatically sets 'extended_history'. The additional
# prefix to each entry prevents 'hist_ignore_all_dups' from working as one might
# expect. The additional timestamps create a destinct entry in the history list.

setopt SHARE_HISTORY
#setopt EXTENDED_HISTORY         # Write the history file in the ':start:elapsed;command' format.
setopt HIST_FCNTL_LOCK          # use fcntl syscall to lock hist file,

setopt HIST_EXPIRE_DUPS_FIRST   # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS         # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS     # Delete an old recorded event if a new event is a duplicate.
                                # only accounts for the current session!
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS        # Do not display a previously found event.
setopt HIST_IGNORE_SPACE        # Don't record input that starts with a blank
setopt HIST_VERIFY              # Do not execute immediately upon history expansion.
setopt HIST_NO_FUNCTIONS        # Don't append functions to the history
setopt HIST_REDUCE_BLANKS       # Truncate additional blanks

unsetopt FLOWCONTROL            # Disable "flow control"/sending the STOP char on C-s/C-q

# =======
# General
# =======

# Add my plugins to the functions path
fpath=("$ZDOTDIR/functions" $fpath)

# Move ZSH completion cache
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Set keymap to viins
KEYTIMEOUT=10; bindkey -v

# ==========
# "Userland"
# ==========

# Handy batch renaming function
autoload -Uz zmv

# Override colors for gnu stuff
# eval "$(dircolors -b $ZDOTDIR/config/dircolors)" 

source "$ZDOTDIR/config/completion.zsh"
source "$ZDOTDIR/config/aliases.zsh"
source "$ZDOTDIR/config/scripts.zsh"
source "$ZDOTDIR/config/keymap.zsh"
source "$ZDOTDIR/config/prompt.zsh"

# ==============
# External tools
# ==============

# zoxide:   Jump to directories. Probably my favorite and most used
#           tool for the shell
# Source:   https://github.com/ajeetdsouza/zoxide
command -v 'zoxide' &>/dev/null && eval "$(zoxide init zsh)"

# spt:      Spotify client for the terminal
# source:   https://github.com/Rigellute/spotify-tui
#command -v 'spt' &>/dev/null && eval "$(spt --completions zsh)"

# fzf:      A very useful and universal cli fuzzy finder
# source:   https://github.com/junegunn/fzf
command -v 'fzf' &>/dev/null && {
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
}

# broot:    A fancy way to view files
# source:   https://github.com/Canop/broot
command -v 'broot' &>/dev/null && eval "$(broot --print-shell-function zsh)"

# ===========
# ZSH plugins
# ===========

# desc:     Something that I'm working on. Probably already exists in a much more useful
#           manner, but it was fun to create non the less and a great little learning exercise.
# source:   TODO

#           Neat auto completions!
# source:   https://github.com/zsh-users/zsh-autosuggestions
source "$ZDOTDIR/extern/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"

# desc:     Very pretty syntax highlighting.
# source:   https://github.com/zsh-users/zsh-syntax-highlighting
# note:     To be sourced at the end of the config or after every call to zle that
#           binds/invokes a (default) widget.
source "$ZDOTDIR/extern/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
