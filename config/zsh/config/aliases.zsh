# My aliases
alias shd='sudo shutdown -h now'
alias rbt='sudo reboot'

## Builtins and Coreutils

alias ls='command ls --color=auto'
alias l='ls -lAh'

alias cp='command cp -v'
alias mv='command mv -v'
alias rm='command rm -v'

alias grep='command grep --color=auto'
alias bc='command bc -lq'
alias pa='command ping 1.1.1.1 -c3'
alias pn='command ping "cloudflare.com" -c3'

alias pgrep='command pgrep -li'
alias pkill='command pkill -ei'

alias objdump='command objdump -M intel'

# dirstack
for i ({0..9}) alias "$i"="pushd +$i"
for i ({0..9}) alias "-$i"="pushd -$i"

# move up, in a more comfortable fashion...
# (i.e. '..2' instead of 'cd ../../')
for i ({2..5}) alias "..$i"="builtin cd $(printf '../%.0s' {1..${i}})"

case "$(uname -r)" in
    *(artix|arch)*)
        local pac='pacman --color=auto'

        alias pacin="command sudo $pac -S"
        alias pacupg="command sudo $pac -Syu"
        alias pacupd="command sudo $pac -Sy"
        alias pacrm="command sudo $pac -Rs"

        alias pacsearch="command $pac -Ss"
        alias pacinfo="command $pac -Si"
        alias pacls="command $pac -Qe"
        alias pacown="command $pac -Qo"

        unset pac
        ;;
esac

## Some useful and commonly used stuff

# mute license banner on startup
alias gdb='command gdb --quiet'
alias rust-gdb='command rust-gdb --quiet'

alias e='exa -la --git'

#  xorg
alias xpropc='command xprop | grep "WM_CLASS"'

# ffmpeg
alias ffmpeg='command ffmpeg -hide_banner'

# neovim
alias n='command $EDITOR'

# git stuff
alias gs='command git status'
alias gc='command git commit'
alias ga='command git add'
