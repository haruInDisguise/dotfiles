alias shd='command sudo systemctl poweroff'

## Builtins and Coreutils
alias ls='command ls --color=auto'
alias l='ls --list --almost-all --human-readable'

alias cp='command cp --verbose'
alias mv='command mv --verbose'
alias rm='command rm --verbose'

alias grep='command grep --color=auto'
alias bc='command bc --mathlib --quiet'
alias pn='command ping "cloudflare.com" -c3'

alias pgrep='command pgrep --list-names --ignore-case'
alias pkill='command pkill --echo --ignore-case'

alias objdump='command objdump --disassembler-options=intel'

# dirstack
alias d='builtin dirs -pv'
for i ({1..4}) alias "$i"="builtin pushd +$i"
for i ({1..4}) alias "-$i"="builtin pushd -$i"

# move up, in a more comfortable fashion...
# (i.e. '..2' instead of 'cd ../../')
for i ({2..5}) alias "..$i"="builtin cd $(printf '../%.0s' {1..${i}})"

case "$(command uname -r)" in
    *(artix|arch)*)
        local pac='pacman --color=auto'

        alias pacin="command sudo $pac --sync --refresh"
        alias pacupg="command sudo $pac --sync --refresh --sysupgrade"
        alias pacrm="command sudo $pac --remove --recursive"

        alias pacsearch="command $pac --sync --search"
        alias pacinfo="command $pac --sync --info"
        alias pacls="command $pac --query --explicit"
        alias pacown="command $pac --query --owns"
        alias paccont="command $pac --query --list"

        unset pac
        ;;
esac

## Some useful and commonly used stuff

# Enable asan support by default?
alias gdb='ASAN_OPTIONS=abort_on_error=1:detect_leaks=0 command gdb --quiet'
alias gdb-mute='gdb --eval-command "start &>/dev/null"'

alias e='command eza -la --git --group-directories-first'

alias xclip='command xclip -selection clipboard'
alias xpropc='command xprop | grep "WM_CLASS"'
alias ffmpeg='command ffmpeg -hide_banner'
alias n='command $EDITOR'

# git stuff
alias gs='command git status'
alias gc='command git commit'
alias ga='command git add'

alias gsign='eval "$(ssh-agent)"; ssh-add "$HOME/.ssh/github"'
