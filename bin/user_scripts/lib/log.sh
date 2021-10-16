# Logging funtions used throughout my user scripts

_write() {
    echo -ne "$@"
}

_writeln() {
    _write $# '\n'
}

get_date() {
    date $@
}
