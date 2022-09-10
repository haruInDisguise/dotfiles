# My aliases

alias shd='sudo shutdown -h now'

## Builtins and Coreutils

alias ls='command ls --color=auto'
alias l='ls -lah'
alias d='cd'

alias cp='command cp -v'
alias mv='command mv -v'
alias rm='command rm -v'

alias grep='command grep --color=auto'
alias bc='command bc -lq'
alias pa='command ping 1.1.1.1 -c3'
alias pn='command ping "cloudflare.com" -c3'

alias pgrep='command pgrep -l'
alias pkill='command pkill -e'

# dirstack and jump up
for i ({0..9}) alias "$i"="pushd +$i"
for i ({0..9}) alias "-$i"="pushd -$i"

for i ({2..5}) alias "..$i"="builtin cd $(printf '../%.0s' {1..${i}})"

case "$(uname -r)" in
    *(artix|arch)*)
        local pac='pacman --color=auto'

        alias pacin="sudo $pac -S"
        alias pacupg="sudo $pac -Syu"
        alias pacupd="sudo $pac -Sy"
        alias pacrm="sudo $pac -Rs"

        alias pacsearch="$pac -Ss"
        alias pacinfo="$pac -Si"
        alias pacls="$pac -Qe"
        alias pacown="$pac -Qo"

        unset pac
        ;;
esac

## Some useful and commonly used stuff

# an ls alternative
[[ -x "$CARGO_HOME/bin/exa" ]] && alias e='exa -la --git'

# no spam in gdb and tui mode! yee
alias gdb='command gdb --quiet --tui'

# xorg
alias xpropc='command xprop | grep "WM_CLASS"'

# ffmpeg
alias ffmpeg='command ffmpeg -hide_banner'

# neovim
alias n='$EDITOR'

