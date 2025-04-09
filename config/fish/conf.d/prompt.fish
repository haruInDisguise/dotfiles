function _prompt_print_exectime --argument-names threshold_ms exectime_ms command
    if test $exectime_ms -lt $threshold_ms
        return
    end

    set -l output ''

    if test $exectime_ms -ge 3600000
        set -l hours (math -s 0 "$exectime_ms / 3600000")
        set -a output "$hours h, "
    end

    if test $exectime_ms -ge 60000
        set -l minutes (math -s 0 "$exectime_ms / 1000 / 60 % 60")
        set -a output "$minutes min, "
    end

    set -l seconds (math -s 0 "$exectime_ms / 1000 % 60")
    set -a output "$seconds sec "

    set -l millis (math -s 0 "$exectime_ms % 1000")
    set -a output "and $millis msec"

    set -l command_parts (string split ' ' $command)
    echo -n "'"(set_color magenta)"$command_parts[1]"
    if test (count $command_parts) -gt 1
        echo -n (set_color blue)" $command_parts[2..]"
    end
    echo -n (set_color normal)"' "

    echo -n (set_color yellow)'took '
    echo $output
end

function _prompt_event_onpwdchange \
        --on-variable PWD \
        --description ""
    command eza -la --git --group-directories-first
end

function _prompt_event_preexec --on-event fish_preexec
end

function _prompt_event_postexec --on-event fish_postexec
    _prompt_print_exectime 3000 $CMD_DURATION $argv
end

function _prompt_event_prompt --on-event fish_prompt
    echo
end

function _prompt_status
    echo -n (__fish_print_pipestatus "" " " "|" (set_color $fish_color_status) \
                                      (set_color --bold $fish_color_status) $argv[1])
end

function _prompt_jobs
    set -f job_count (count (jobs))

    if test $job_count -gt 0
        echo -n "$(set_color yellow)"["$job_count"]"$(set_color normal)"
    end
end

function fish_prompt
    set -f last_status $status
    set -f last_pipestatus $pipestatus
    set -f indicator_color --bold green

    if test $last_status -gt 0
        set -f indicator_color --bold red
    end

    #echo -n (prompt_pwd)' '
    echo -n (pwd | string replace "$HOME" '~')' '
    echo -n (_prompt_jobs)' '
    echo -n (_prompt_status $last_pipestatus)

    echo -n "$(set_color $indicator_color)>$(set_color normal)"
    echo ' '
end

function fish_right_prompt
    # ...
    set -g __fish_git_prompt_showupstream auto
    set -g __fish_git_prompt_showstashstate 1
    set -g __fish_git_prompt_showcolorhints 1

    printf '%s' (fish_git_prompt)
end

function fish_command_not_found
    printf (_ "fish: Unknown command: %s\n") (string escape -- $argv[1]) >&2
end

# Do not print a mode prompt
function fish_mode_prompt; end

