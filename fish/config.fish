if status is-interactive
    # Commands to run in interactive sessions can go here
end

function full_path
    set cwd (pwd)
    set home (echo $HOME)
    # substitui $HOME pelo til (~)
    if test (string match -r "^$home" $cwd)
        set cwd " ~"(string sub -s (math (string length $home) + 1) -- $cwd)
    end
    echo $cwd
end

function fish_prompt
    set_color green
    echo -n (full_path) '> '
    set_color normal
end


set -g fish_greeting
set -g theme_display_git yes
set -g theme_git_worktree_support yes
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes

alias pipes='pipes.sh -c 2'
alias update='sudo pacman -Syu'
alias gc="git add . && git commit -m 'Atualização automática' && git push"
alias fetch="bash ~/dotfiles/fetch/fetch.sh"
