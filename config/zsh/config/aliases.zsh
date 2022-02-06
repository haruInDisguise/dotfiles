# My aliases

# Shutdown and reboot
alias shd='sudo shutdown -h now'

## Builtins and Coreutils

# ls
alias ls='ls --color=auto'
alias l='ls -lah'
[[ -x $CARGO_HOME/bin/exa ]] && alias e='exa -la --git'

# cp, mv, rm
alias cp='cp -iv'
alias rm='rm -v'
alias mv='mv -iv'

alias grep='grep --color=auto'
alias bc='bc -lq'
alias pg='ping 8.8.8.8 -c3'

# dirstack and jump up
# for i ({0..9}) alias "$i"="pushd -$i"
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

# X11
alias xpropc='xprop | grep "WM_CLASS"'

# youtube_dl
alias yta='youtube-dl --audio-format opus -x'

# neovim
alias n='$EDITOR'
alias vim='$EDITOR'
alias ntmp='$EDITOR $(mktemp /tmp/XXXXXXXXXX.md)'
alias ntmpconst='$EDITOR '"$(mktemp /tmp/XXXXXXXXXX.md)"

# git
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gc='git commit'

