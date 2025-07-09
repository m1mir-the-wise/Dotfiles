if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

alias gc="git add . && git commit -m 'Atualização Automátizada' && git push"
alias fetch="bash ~/dotfiles/fetch/fetch.sh"
alias pipes="pipes.sh -c 2"
