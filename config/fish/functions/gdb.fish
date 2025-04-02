
function gdb --description 'UBSAN_OPTIONS=abort_on_error=1:halt_on_error=1 ASAN_OPTIONS=abort_on_error=1:detect_leaks=0 command gdb --quiet'
    UBSAN_OPTIONS=abort_on_error=1:halt_on_error=1 ASAN_OPTIONS=abort_on_error=1:detect_leaks=0 command gdb --quiet $argv
end

alias gdb-mute='gdb --eval-command "start &>/dev/null"'

