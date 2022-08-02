zle_bind() {
    local keymap="$1"
    local key="$2"
    local widget="$3"

    bindkey -M "$keymap" "$key" "$widget"
}

zle_register_and_bind() {
    local widget="$3"

    # Both calls always succeed
    autoload -Uz "$widget"
    zle -N "$widget"

    zle_bind $1 $2 $widget
}

# Enable vi mode
KEYTIMEOUT=1; bindkey -v

zle_register_and_bind vicmd 'v' edit-command-line

zle_bind vicmd 'R' push-line-or-edit

zle_bind main '^k' up-line-or-history
zle_bind main '^j' down-line-or-history

unfunction zle_register_and_bind zle_bind

