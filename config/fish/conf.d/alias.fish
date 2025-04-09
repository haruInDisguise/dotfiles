for i in (seq 2 5);
    alias "..$i"="builtin cd $(printf '../%.0s' (seq 1 $i))"
end

set pac 'pacman --color=auto'
alias pacin="command sudo $pac --sync --refresh"
alias pacupg="command sudo $pac --sync --refresh --sysupgrade"
alias pacrm="command sudo $pac --remove --recursive"

alias pacsearch="command $pac --sync --search"
alias pacinfo="command $pac --sync --info"
alias pacls="command $pac --query --explicit"
alias pacown="command $pac --query --owns"
alias paccont="command $pac --query --list"
set -e pac

alias e='command eza -la --git --group-directories-first'
alias n='command $EDITOR'

# git stuff
alias gs='command git status'
alias gc='command git commit'
alias ga='command git add'
alias gst='command git stash'

alias gsign='eval "$(ssh-agent -c)"; ssh-add "$HOME/.ssh/github"'
