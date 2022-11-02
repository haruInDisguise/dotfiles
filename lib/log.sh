# Default logging definitions.
# To be sourced within scripts: '. "$DOTFILES_ROOT/scripts/log.sh"'

if [ -z "$_DOTFILES_LOG_SH_" ]; then
    _DOTFILES_LOG_SH_=1

    LOG_LEVEL_DEBUG="$(tput setaf 4)debug$(tput sgr0)"
    LOG_LEVEL_INFO="$(tput setaf 2)info $(tput sgr0)"
    LOG_LEVEL_WARN="$(tput setaf 3)warn $(tput sgr0)"
    LOG_LEVEL_ERROR="$(tput setaf 1)error$(tput sgr0)"

    _log_fmt() {
        _log_fmt_level="$1"; shift
        _log_fmt_msg="$@"
        _log_fmt_date="$(tput sgr0) $(date -u '+%Y-%m-%dT%H:%M:%SZ')$(tput sgr0)"

        echo -e "$(tput setaf 0)[$_log_fmt_date\t $_log_fmt_level$(tput setaf 0)]$(tput sgr0) $_log_fmt_msg"
    }

    log_debug() {
        _log_fmt "$LOG_LEVEL_DEBUG" $@
    }

    log_info() {
        _log_fmt "$LOG_LEVEL_INFO" $@
    }

    log_warn() {
        _log_fmt "$LOG_LEVEL_WARN" $@
    }

    log_error() {
        _log_fmt "$LOG_LEVEL_ERROR" $@ >&2
    }
fi
