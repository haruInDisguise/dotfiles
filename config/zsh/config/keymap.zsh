zle-bind() {
    local keymap="$1"
    local key="$2"
    local widget="$3"

    bindkey -M "$keymap" "$key" "$widget"
}

zle-register-and-bind() {
    local widget="$3"

    # Both calls always succeed
    autoload -Uz "$widget"
    zle -N "$widget"

    zle-bind $1 $2 $widget
}

# Enable vi mode
KEYTIMEOUT=1; bindkey -v

zle-register-and-bind vicmd 'v' edit-command-line
zle-register-and-bind vicmd 'L' pipe-command-results-to-pager

zle-bind vicmd 'R' push-line-or-edit

zle-bind viins '^k' vi-cmd-mode

unfunction zle-register-and-bind zle-bind

