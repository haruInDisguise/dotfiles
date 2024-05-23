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
        local cursor_insert="${disable_blink}\x1b[6 q"
        local cursor_cmd="${disable_blink}\x1b[2 q"

        # $KEYMAP seems to equal 'main' AND
        # 'viins' when changing into insert mode
        print -n -- "${${KEYMAP/main/$cursor_insert}/vicmd/$cursor_cmd}"
    }

    zmodload 'zsh/zle'
    zle -N zle-line-init
    zle -N zle-keymap-select
}

_prompt_setup_exectime() {
    zmodload 'zsh/datetime'

    typeset -gF _prompt_exectime_start_epoch_nsec=0
}

_prompt_exectime_print_elapsed() {
    local cmd=(${(s: :)_prompt_stats_command})
    cmd="$cmd[1]"
    local epoch_diff="$((EPOCHREALTIME - _prompt_exectime_start_epochtime))"
    epoch_diff=(${(s:.:)epoch_diff})

    [[ -z "$_prompt_stats_command" ]] && return
    [[ $cmd == 'time' ]] && return
    [[ "${(v)builtins[$cmd]}" == 'defined' ]] && return

    for diff_sec diff_nsec in $epoch_diff; do
        [[ $diff_sec -lt 3 ]] && return

        local hours=$((diff_sec / 3600))
        local min=$((diff_sec / 60 % 60))
        local sec=$((diff_sec % 60))
        local msec="${diff_nsec[1,3]}"

        # FIXME: CMD might contain characters that will be expanded
        # by the shell, leading to misformatted results. Escape cmd.
        # Example: "sleep 3 && print -- $_"
        local output="\"%F{cyan}${_prompt_stats_command}%F{yellow}\" took "
        [[ "$hours" -gt 0 ]] && output+="${(l:2::0:)hours} h, "
        [[ "$min"   -gt 0 ]] && output+="${(l:2::0:)min} min, "
        output+="${(l:2::0:)sec} sec "
        output+="and ${msec} msec"

        print -P -- "\n%F{yellow}${output}"
    done
}

_prompt_hook_precmd() {
    # print exectime
    _prompt_exectime_print_elapsed
    _prompt_stats_command=""
    _prompt_exectime_start_epochtime=""

    # populate git
    vcs_info

    # print a newline
    print
}

_prompt_hook_preexec() {
    _prompt_exectime_start_epochtime="$EPOCHREALTIME"
    _prompt_stats_command="$1"
}

_prompt_hook_chpwd() {
    { alias e &>/dev/null && e } || ls -lAh
}

_prompt_setup() {
    # see https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
    setopt promptsubst

    _prompt_setup_vimode
    _prompt_setup_vcs_info
    _prompt_setup_exectime

    precmd_functions+=( _prompt_hook_precmd )
    preexec_functions+=( _prompt_hook_preexec )
    chpwd_functions+=(  _prompt_hook_chpwd )

    local section_status='%(?..%? )'
    local section_symbol='%(!.#.>)'

    local section_path='%~ '
    local section_indicator_color='%B%F{%(?.green.red)}'

    # unterminated text
    PROMPT_EOL_MARK="%K{white} %k"

    # PS1 - primary prompt
    PS1="${section_path}"
    PS1+="${section_indicator_color}${section_status}${section_symbol}%f%b "

    RPROMPT='${vcs_info_msg_0_}'

    # PS2 - blocks
    PS2='%F{green}%_%f %B%F{yellow}>%f%b '
}

_prompt_setup
