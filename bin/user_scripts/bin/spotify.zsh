#!/usr/bin/zsh

# Launch librespot... and handle some things... yay

# see: https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html#zero-handling
SCRIPT_PATH="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
SCRIPT_PATH="${${(M)0:#/*}:-$PWD/$0}"

typeset -A script_options=(
    librespot_cache_path "$XDG_CACHE_HOME/librespot"
    log_level            info
    # Detach librespot
    as_daemon            false
    # Mute any logging produced by librespot
    mute_librespot       false
    # If the start options is invoked during runtime...
    restart_on_running   true
)

typeset -a librespot_options=(
    --backend   rodio # TODO: Look into 'gstreamer' backend...
    --cache     $script_options[librespot_cache_path]
    --name      "$(uname -n)"
    --bitrate   320
    --format    F32
    --onevent   "librespot_event"
    --initial-volume 100
)

# Fancy prints
_fmt_print() \
    print -P -- "%F{black}[%f$(date '+%Y-%m-%dT%H:%M:%SZ') %F{$2}$1%f ${SCRIPT_PATH:t}%F{black}]%f\t" "${(%%)3}"
print_error()   { _fmt_print 'ERROR' red     "$@" }
print_warn()    { _fmt_print 'WARN ' yellow  "$@" }
print_info()    { _fmt_print 'INFO ' green   "$@" }
print_error_and_exit() { print_error $@; exit 1 }

if [[ $script_options[log_level] == debug ]]; then
    print_debug()   { _fmt_print DEBUG cyan "$@" }
else
    print_debug() {}
fi

show_help() {
    local -a msg=(
        'Usage: spotify <help|event|start>'
        ''
        ''
        '  Arguments:'
        '      help:   Display this text'
        '      exit:   Terminate any running librespot instances'
        '      run:    [default] Launch librespot and pass it all supsequent arguments'
        '              NOTE:   this might effect the cache and therefore further'
        '                      script invocations. TODO: Make this practical/functional'
        ''
        "This script trys to launch 'librespot' using"
        "the following cache path: '"'$XDG_CACHE_HOME/librespot'"' ('current value: $script_options[librespot_cache_path]')."
        ''
        "A fresh launch might leak credentials into the"
        "process tree/'cmdline', as librespot takes credentials"
        "in the form of arguments (one might pass the password"
        "through stdin by omitting the '--password' field)."
        "On subsequent calls, this script will use/consult the"
        "cached data."
    )

    print -rC1 -- "$msg[@]"
}

handle_unknown() {
    print_warn "Unknown argument: $@\n"
    show_help
    exit 2
}

handle_exit() {
    # TODO: Maybe use a PID file?
    print_warn "$0: This is a bit ugly... proceeding to 'kill -TERM librespot' ... (͡ ° ͜ʖ ͡ °)"
    if ! builtin kill -TERM $(pidof librespot) 2>/dev/null; then
        print_error_and_exit "$0: Failed to terminate librespot"
    fi
}

launch_librespot() {
    local pid_librespot cmd

    # Librespot uses a directory to store cache (execute = 'cd' able)
    if [[ ! -x "$script_options[librespot_cache_path]" ]]; then
        print_warn "$0: "'Unable to locate librespot cache'

        librespot_options+=(
          --username  "$(pass web/spotify/username)" # TODO: Auth using zeroconf?
          --password  "$(pass web/spotify/password)"
        )
    fi

    cmd="librespot ${(u)librespot_options}"

    [[ $script_options[mute_librespot] == true ]] && cmd+=" &>/dev/null"
    [[ $script_options[as_daemon] == true ]] && cmd+=" &!"

    eval "$cmd"
}

main() {
    if command pidof librespot >/dev/null; then
        if [[ $script_options[restart_on_running] == true ]]; then
            print_info "$0: found running instance. restarting"
            handle_exit
        else
            print_error_and_exit "$0: there is already a running instance of librespot"
        fi
    fi

    command -v wget >/dev/null || \
        print_error_and_exit "$0: unable to locate 'wget' binary in PATH (required to check network access)"

    # :p
    command wget -q --tries=10 --timeout=3 --spider 'https://duckduckgo.com' &>/dev/null || \
        print_error_and_exit "$0: unable to connect to the internet"

    launch_librespot $@
}

emulate -L zsh

# TODO: Improve argument handeling...
_cmd="$1"

if [[ "$_cmd" == "" ]]; then
    print_debug "No command specified. Falling back to 'start'"
    _cmd='start'
fi

case "$_cmd" in
    'start')
        main $@
        ;;
    'exit')
        handle_exit
        ;;
    'help')
        show_help
        ;;
    ?*)
        handle_unknown $@
        ;;
esac

