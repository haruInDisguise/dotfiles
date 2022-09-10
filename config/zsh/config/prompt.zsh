# TODO:
# - measure execution time beyond a threshould (add start/end time)
# - expand git integration
# - dynamically shrink path/add linebreak (I think, zsh has a builtin
#   feature for this... %<string<?)

_prompt_setup_vcs_info() {
    autoload -Uz vcs_info

    # see: https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' max-exports 1 # discard backup?

    zstyle ':vcs_info:*' formats '%F{cyan}%r%f %F{yellow}%f %F{magenta}%b%f %c%u'
    zstyle ':vcs_info:*' actionformats '%a ${fg_bold[yellow]}${reset}'
    zstyle ':vcs_info:*' patchformats 'patched'

    zstyle ':vcs_info:*' check-for-changes true

    zstyle ':vcs_info:*' stagedstr '%F{green}%f '
    zstyle ':vcs_info:*' unstagedstr '%F{red}%f '
}

_prompt_setup_vimode() {
    zle-line-init zle-keymap-select() {
        local cursor_insert=$'\x1b[5 q'
        local cursor_cmd=$'\x1b[2 q'
        local mode_disable_blink=$'\x1b[25'

        # $KEYMAP seems to equal 'main' AND
        # 'viins' when changing into insert mode
        print -n -- "${${KEYMAP/main/$cursor_insert}/vicmd/$cursor_cmd}"
    }

    zmodload 'zsh/zle'
    zle -N zle-line-init
    zle -N zle-keymap-select
}

# TODO: AHHH
_prompt_setup_exectime() {
    zmodload 'zsh/datetime'

    typeset -gF _prompt_exectime_start_epoch_nsec=0
}

_prompt_hook_precmd() {
    _prompt_exectime_diff_epoch_nsec="$((EPOCHREALTIME - _prompt_exectime_start_epoch_nsec))"

    vcs_info

    print
}

_prompt_hook_preexec() {
    _prompt_exectime_start_epoch_nsec="$EPOCHREALTIME"
}

_prompt_setup() {
    # see https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
    setopt promptsubst

    _prompt_setup_vimode
    _prompt_setup_vcs_info
    _prompt_setup_exectime

    precmd_functions+=( _prompt_hook_precmd )
    preexec_functions+=( _prompt_hook_preexec )

    local prompt_section_status='%(?..%? )'
    local prompt_section_symbol='%(!.#.>)'

    local prompt_section_path='%~ '
    local prompt_section_indicator_color='%B%F{%(?.green.red)}'

    # unterminated text
    PROMPT_EOL_MARK="%K{white} %k"

    # PS1 - primary prompt
    PS1="$prompt_section_path"
    PS1+="$prompt_section_indicator_color$prompt_section_status$prompt_section_symbol%f%b "

    RPROMPT='${vcs_info_msg_0_}'

    # PS2 - blocks
    PS2='%F{green}%_%f %B%F{yellow}>%E '
}

_prompt_setup
