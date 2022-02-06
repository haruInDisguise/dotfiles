# Default definitons for logging functions.

# USAGE: 
# Define 'USER_LOG_LEVEL' BEFORE sourcing this file in your script
# 'USER_LOG_LEVEL' can be a value of 0-4, each digit representing
# the status levels 'DISABLED', 'ERROR', 'WARN', 'INFO' and 'DEBUG'
# respectively. There is a sixth option, 'USER_LOG_ALL', that is equal
# to 'USER_LOG_DEBUG' i. e. the highest logging level.
#
# If no log level is set and/or set to an invalid value, a warning
# is printed and the logging behaves as if it had been set to 'USER_LOG_ALL'
#
# The variable 'USER_LOG_PATH_FORMAT' may be set to "full" to display
# the entire file path in the final output
#
# EXAMPLE:
# USER_LOG_LEVEL="$USER_LOG_WARN"
# warn "This is a warning! It gets printed"
# info "This is an info. Due to the log level status, it will be ignored"

# Shortcuts/Enums for 'USER_LOG_LEVEL' values
_USER_LOG_DISABLE=0
_USER_LOG_ERROR=1
_USER_LOG_WARN=2
_USER_LOG_INFO=3
_USER_LOG_DEBUG=4
_USER_LOG_ALL="$_USER_LOG_DEBUG"

# =====================

_USER_LOG_CLR_RED='\033[31m'
_USER_LOG_CLR_YLW='\033[33m'
_USER_LOG_CLR_GRN='\033[32m'
_USER_LOG_CLR_CYN='\033[34m'
_USER_LOG_RESET='\033[0m'

# Setting a default value
_USER_LOG_LEVEL="${USER_LOG_LEVEL:-$_USER_LOG_ALL}"
_USER_LOG_PATH_TYPE="${USER_LOG_PATH_TYPE:-"full"}"

if [ "$_USER_LOG_PATH_TYPE" = "full" ]; then
    _USER_LOG_PATH_FMT=" ($0) "
elif [ "$_USER_LOG_PATH_TYPE" = "base" ]; then
    _USER_LOG_PATH_FMT=" ($(basename $0)) "
else
    _USER_LOG_PATH_FMT=""
fi

_write_to_stdout() {
    printf "%b" "$@\n"
}

_write_to_stderr() {
    printf "%b" "$@\n" >&2 
}

_write_fmt_stdout() {
    _write_to_stdout "[$1]$_USER_LOG_PATH_FMT" "$2"
}

_write_fmt_stderr() {
    _write_to_stderr "[$1]$_USER_LOG_PATH_FMT" "$2"
}

# Define ERROR
if [ "$_USER_LOG_LEVEL" -ge "$_USER_LOG_ERROR" ]; then
    error() {
        _write_fmt_stderr "$_USER_LOG_CLR_RED ERROR $_USER_LOG_RESET" "$@"
    }

    # Exit and print an error message.
    # Args:
    # 1: Message to send
    # 2: Optional return code
    error_and_die() {
        error "$1"
        exit "${2:-1}"
    }
else
    error() {
        return
    }

error_and_die() {
    exit "${2:-1}"
}
fi

# Define WARN
if [ "$_USER_LOG_LEVEL" -ge "$_USER_LOG_WARN" ]; then
    warn() {
        _write_fmt_stdout "$_USER_LOG_CLR_YLW WARN  $_USER_LOG_RESET" "$*"
    }
else
    warn() {
        return
    }
fi

# Define INFO
if [ "$_USER_LOG_LEVEL" -ge "$_USER_LOG_INFO" ]; then
    info() {
        _write_fmt_stdout "$_USER_LOG_CLR_GRN INFO  $_USER_LOG_RESET" "$*"
    }
else
    info() {
        return
    }
fi

# Define DEBUG
if [ "$_USER_LOG_LEVEL" -ge "$_USER_LOG_DEBUG" ]; then
    debug() {
        _write_fmt_stdout "$_USER_LOG_CLR_CYN DEBUG $_USER_LOG_RESET" "$*"
    }
else
    debug() {
        return
    }
fi

