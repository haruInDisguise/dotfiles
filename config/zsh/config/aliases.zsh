# My aliases

# Some quick acess stuff. Unset at the end
typeset -A zsh_options_aliases=(
    dirstack_acess_range "$(print {0..9})"
    linux_kernel_distro "$(uname -r)"
)

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
alias bc='bc -q'
alias pg='ping 8.8.8.8 -c3'

## ZSH

# dirstack and jump up
for i ({0..9}) alias "$i"="pushd -$i"
for i ({2..5}) alias "..$i"="builtin cd $(printf '../%.0s' {1..${i}})"

## OTHER PROGRAMS
case "$zsh_options_aliases[linux_kernel_distro]" in
    *(artix|arch)*)
        alias pac='sudo pacman --color=auto'
        alias pacin='pac -S'
        alias pacupg='pac -Syu'
        alias pacupd='pac -Sy'
        alias pacrm='pac -Rs'
        alias pacsearch='pac -Ss'
        alias pacinfo='pac -Si'
        alias pacdown='pac -Suu' 
        alias pacls='pac -Qe'
        alias pacown='pac -Qo'
        ;;
esac

## Some useful and commonly used stuff

# X11
alias xpropc='xprop | grep "WM_CLASS"'

# youtube_dl
alias yta='youtube-dl --audio-format opus -x'

# neovik
alias n='$EDITOR'
alias vim='$EDITOR'
alias ntmp='$EDITOR $(mktemp /tmp/XXXXXXXXXX.md)'

# git
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gc='git commit'

unset zsh_options_aliases

