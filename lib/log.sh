# Default logging definitions.
# To be sourced within scripts: '. "$DOTFILES_ROOT/scripts/log.sh"'

if [ -z "$_DOTFILES_LOG_SH_" ]; then
    _DOTFILES_LOG_SH_=1

    _LOG_LEVEL=0
    LOG_LEVEL="${LOG_LEVEL:-all}"
    case "$LOG_LEVEL" in
        'all') _LOG_LEVEL=0;;
        'debug') _LOG_LEVEL=1;;
        'info') _LOG_LEVEL=2;;
        'warn') _LOG_LEVEL=3;;
        'error') _LOG_LEVEL=4;;
        'none') _LOG_LEVEL=5;;
    esac

    _log_fmt() {
        _log_fmt_level="$1"; shift
        _log_fmt_msg="$@"
        _log_fmt_date="$(tput sgr0)$(date -u '+%Y-%m-%dT%H:%M:%SZ')$(tput sgr0)"
        _log_fmt_prefix="$(tput setaf 0)["
        _log_fmt_postfix="$(tput sgr0)${LOG_NAME:-dotfiles} $(tput setaf 0)]$(tput sgr0)"

        echo "$_log_fmt_prefix$_log_fmt_date $_log_fmt_level $_log_fmt_postfix $_log_fmt_msg"
    }

    log_debug() {
        if [ "$_LOG_LEVEL" -le 1 ]; then
            _log_fmt "$(tput setaf 4)DEBUG$(tput sgr0)" $@
        fi
    }

    log_info() {
        if [ "$_LOG_LEVEL" -le 2 ]; then
            _log_fmt "$(tput setaf 2)INFO $(tput sgr0)" $@
        fi
    }

    log_warn() {
        if [ "$_LOG_LEVEL" -le 3 ]; then
            _log_fmt "$(tput setaf 3)WARN $(tput sgr0)" $@
        fi
    }

    log_error() {
        if [ "$_LOG_LEVEL" -le 4 ]; then
            _log_fmt "$(tput setaf 1)ERROR$(tput sgr0)" $@ >&2
        fi
    }

    error_and_exit() {
        log_error $@
        exit 1
    }
fi
