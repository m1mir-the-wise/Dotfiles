if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g theme_display_user yes
set -g theme_display_hostname yes
set -g theme_nerd_fonts yes
set -g theme_color_scheme dracula
set -g theme_display_git yes
set -g theme_show_exit_status yes
set -g theme_newline_cursor underscore
alias ls='exa --icons'
alias update='sudo pacman -Syu'
alias pipes='pipes.sh -c 2'
