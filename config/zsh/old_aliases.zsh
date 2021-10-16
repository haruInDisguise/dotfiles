# My aliases

# Shutdown and reboot
alias shd="sudo shutdown -h now"

## Builtins and Coreutils

# ls
alias ls="exa --color=auto"
alias l="ls -lag@"

# cp, mv, rm
alias cp="cp -iv"
alias rm="rm -i"
alias mv="mv -iv"

# grep
alias grep="grep --color=auto"
alias rgrep="grep -r"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# bc
alias bc="bc -q"

# ping
alias pg="ping 8.8.8.8"

# dirstack
alias d="dirs -v"
for index ({1..9}) alias "$index"="cd +${index}"; unset index

## Other programs

# pacman
alias pac="sudo pacman --color=auto"
alias pacin="pac -S"
alias pacupg="pac -Syu"
alias pacupd="pac -Sy"
alias pacclr="pac -Sc"
alias pacclrf="pac -Scc"
alias pacrm="pac -Rs"
alias pacsearch="pac -Ss"
alias pacinfo="pac -Si"
alias pacdown="pac -Suu" 
alias pacls="pac -Qe"
alias pacown="pac -Qo"

## Some useful and commonly used stuff

# X11
alias xpropc="xprop | grep 'WM_CLASS'"

# youtube_dl
alias yta="yt --audio-format opus -x"
alias ytam="yta --exec 'mv {} /mnt/data/music/{}'"

# neovim
alias n="$EDITOR"
alias vim="$EDITOR"
alias ntmp="n $(mktemp /tmp/XXXXXXXXXX.md)"

# git
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'

# steam

## Personal shortcuts

# Change Keymap
alias setkbde="setxkbmap de"
alias setkbus="setxkbmap us"

# Folders
alias fprj="$HOME/projects"
alias fsrc="$HOME/.local/src"
alias fweb="$HOME/projects/server"

alias code="codium --user-data-dir /mnt/data/dev/config/codium --extensions-dir /mnt/data/dev/config/codium/ext"
