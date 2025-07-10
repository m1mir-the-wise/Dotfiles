if status is-interactive
    # Commands to run in interactive sessions can go here
end

# function full_path
#     set cwd (pwd)
#     set home (echo $HOME)
#     if test (string match -r "^$home" $cwd)
#         set cwd " ~"(string sub -s (math (string length $home) + 1) -- $cwd)
#     end
#     echo $cwd
# end
#
# function fish_prompt
#     set_color green
#     echo -n (full_path) '> '
#     set_color normal
# end

set -g fish_greeting
set -Ux EDITOR nvim

alias gc="git add . && git commit -m 'Atualização Automatizada' && git push"
alias fetch="bash ~/dotfiles/fetch/fetch.sh"
alias pipes="pipes.sh -c 2"
alias sync_simplicity="sudo rm -rf /usr/share/sddm/themes/simplicity && sudo cp -r ~/dotfiles/simplicity /usr/share/sddm/themes/"
