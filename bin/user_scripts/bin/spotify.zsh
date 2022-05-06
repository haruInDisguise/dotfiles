#!/usr/bin/zsh

# Launch librespot... and handle some things... yay
SCRIPT_PATH="${${(M)0:#/*}:-$PWD/$0}"

typeset -A script_options=(
    librespot_cache "$XDG_CACHE_HOME/librespot"
    quiet               true
    verbose             false
    daemon              true
    restart_if_running  true
)

typeset -a librespot_options=(
    --backend   rodio # TODO: Look into 'gstreamer' backend...
    --cache     $script_options[librespot_cache]
    --name      "$(uname -n)"
    --bitrate   320
    --format    F32
    --onevent   "librespot_event"
    --initial-volume 100
)

# Fancy prints
_fmt_print() \
    { print -P -- "%F{black}[%f$(date '+%Y-%m-%dT%H:%M:%SZ') %F{$2}$1%f ${SCRIPT_PATH:t}%F{black}]%f\t" "${(%%)3}"; }
error()   { _fmt_print 'ERROR' red     "$@"; }
warn()    { _fmt_print 'WARN ' yellow  "$@"; }
info()    { _fmt_print 'INFO ' green   "$@"; }
error_and_exit() { error $@; exit 1 }

if [[ $script_options[log_level] == debug ]]; then
    debug()   { _fmt_print DEBUG cyan "$@" }
else
    debug() {}
fi

handle_help() {
    local -a msg=(
        'Usage: spotify <help|event|start>'
        ''
        '  Arguments:'
        '      help:   Display this text'
        '      exit:   Terminate any running librespot instances'
        '      run:    [default] Launch librespot and pass it all supsequent arguments'
        '              NOTE:   this might effect the cache and therefore further'
        '                      script invocations. TODO: Make this practical/functional'
        ''
        ' Options:'
        '     --verbose'
        '     --quiet'
        '     --daemon'
        '     --librespot-options'
        '     --'
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

parse_arguments() {
    local index=0

}

handle_unknown() {
    warn "Unknown argument: $@\n"
    show_help
    exit 2
}

handle_exit() {
    # TODO: Maybe use a PID file?
    warn "$0: This is a bit ugly... proceeding to 'kill -TERM librespot' ... (͡ ° ͜ʖ ͡ °)"
    if ! builtin kill -TERM $(pidof librespot) 2>/dev/null; then
        error_and_exit "$0: Failed to terminate librespot"
    fi
}

launch_librespot() {
    local pid_librespot cmd

    # Librespot uses a directory to store cache (execute = 'cd' able)
    if [[ ! -x "$script_options[librespot_cache]" ]]; then
        warn "$0: "'Unable to locate librespot cache'

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

handle_run() {
    if command pidof librespot >/dev/null; then
        if [[ $script_options[restart_on_running] == true ]]; then
            info "$0: found running instance. restarting"
            handle_exit
        else
            error_and_exit "$0: there is already a running instance of librespot"
        fi
    fi

    command -v wget >/dev/null || \
        error_and_exit "$0: unable to locate 'wget' binary in PATH (required to check network access, add option '--skip-network-check' to ignore this check)"

    # :p
    command wget -q --tries=10 --timeout=3 --spider 'https://duckduckgo.com' &>/dev/null || \
        error_and_exit "$0: unable to connect to a network or name resolution failed"

    launch_librespot $@
}

parse_arguments() {
    while arg in "$@"; do
        case "$arg" in
            '--restart-if-running=true') $script_options[restart_if_running]=true;;
            '--headless') $script_options[headless]=true;;
            '--');;
        esac

    done
}

warn 'FIX: argument parsing is work in progress'
warn 'FIX: skip argument parsing'
#parse_arguments $argv

_cmd=start
case "$_cmd" in
    'start')
        handle_run $@
        ;;
    'exit')
        handle_exit
        ;;
    'help')
        handle_help
        ;;
    ?*)
        handle_unknown $@
        ;;
esac

