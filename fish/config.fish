if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Nerd Font
set -g theme_nerd_fonts yes

# Estilo pastel bonito
set -g theme_color_scheme zenburn  # ou dracula, ou solarized-dark

# Mostrar usuário + host
set -g theme_display_user yes
set -g theme_display_hostname yes

# Mostrar diretório encurtado
set -g theme_display_path yes
set -g theme_display_path_short yes

# Mostrar Git
set -g theme_display_git yes
set -g theme_git_worktree_support yes

# Relógio com ícone nerd font
set -g theme_display_time yes
set -g theme_display_time_format "%H:%M"

# Visual extra
set -g theme_display_jobs yes
set -g theme_show_exit_status yes
set -g theme_newline_cursor blockalias ls='exa --icons'
alias update='sudo pacman -Syu'
alias pipes='pipes.sh -c 2'
