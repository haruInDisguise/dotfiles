function zsh_on_keymap_select {
    # This is a bit nasty... Split init and select? ehhh....
    # zle-keymap-select:
    # Executed every time the keymap changes
    # $1 = old keymap
    # zle-line-init: Called on line reset
    function zle-line-init zle-keymap-select {
        local cursor_cmd='\e[2 q'
        local cursor_ins='\e[6 q'
        local cursor_current="${${KEYMAP/vicmd/$cursor_cmd}/(viins|main)/$cursor_ins}"

        echo -ne $cursor_current

        # Uncomment to update the prompt. Currently using cursor only indicator
        # zle reset-prompt
    }
    
    zle -N zle-keymap-select
    zle -N zle-line-init
}

zsh_on_keymap_select
unfunction zsh_on_keymap_select
