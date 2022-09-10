drop_cache() {
    emulate -L zsh

    local level="${1:-1}"
    local msg='Dropped '

    case "$level" in
        '1') msg+='pages' ;;
        '2') msg+='inodes/dentries' ;;
        '3') msg+='all (pages/inodes/dentries)' ;;
        *) print -- 'Specify a value from 1 to 3 (inclusive)'; return 1 ;;
    esac

    print -- $level | sudo tee /proc/sys/vm/drop_caches &>/dev/null
    print -- "$msg"
}


# ZLE "widgets" for custom mappings

pipe-command-results-to-pager() {
    local pager='less'
    eval "r | $pager"
}

