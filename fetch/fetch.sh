#!/bin/bash

# Cores
GREEN="\e[1;32m"
RESET="\e[0m"

# Funções para capturar informações
get_user() {
  echo "$USER"
}

get_hostname() {
  echo "$HOSTNAME"
}

get_os() {
  grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"'
}

get_kernel() {
  uname -r
}

get_uptime() {
  uptime -p | sed 's/up //'
}

get_shell() {
  basename "$SHELL"
}

get_cpu() {
  grep 'model name' /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^ //'
}

get_mem() {
  mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
  mem_available=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
  mem_used=$((mem_total - mem_available))
  echo "$((mem_used / 1024))MB / $((mem_total / 1024))MB"
}

get_disk() {
  df_output=$(df -h / | awk 'NR==2')
  used=$(echo $df_output | awk '{print $3}')
  total=$(echo $df_output | awk '{print $2}')
  echo "$used / $total"
}

# 🪟 Window Manager (Wayland/X11)
get_wm() {
if [ -n "$XDG_CURRENT_DESKTOP" ]; then
    echo "$XDG_CURRENT_DESKTOP"
  elif [ -n "$DESKTOP_SESSION" ]; then
    echo "$DESKTOP_SESSION"
  elif [ -n "$WAYLAND_DISPLAY" ]; then
    # Detecta Hyprland, sway, etc.
    pgrep -l -u "$USER" | grep -E 'hyprland|sway|wayfire|river|dwl' | awk '{print $2}' | head -n1
  else
    echo "Desconhecido"
  fi
}

get_terminal() {
    ppid1=$(ps -p $$ -o ppid=)
    ppid2=$(ps -p $ppid1 -o ppid=)
    terminal=$(ps -p $ppid2 -o comm=)
    echo $terminal
}

get_packages() {
    echo "$(pacman -Q | wc -l)"
}

clear
echo ""
echo ""
echo -e "${GREEN}                   -'                   ------------------------------ "
echo -e "${GREEN}                  .o+'                  |  Usuário:${RESET} $(get_user)"
echo -e "${GREEN}                 'ooo/                  |  Hostname:${RESET} $(get_hostname)"
echo -e "${GREEN}                '+oooo:                 |  Sistema:${RESET} $(get_os)"
echo -e "${GREEN}               '+oooooo:                |  Kernel:${RESET} $(get_kernel)"
echo -e "${GREEN}               +oooooo+:                ------------------------------"
echo -e "${GREEN}             '/:-:++oooo+:              |  Window Manager:${RESET} $(get_wm)"
echo -e "${GREEN}            ´/++++/+++++++:             |  Shell:${RESET} $(get_shell)"
echo -e "${GREEN}           '/++++++++++++++:            |  Terminal:${RESET} $(get_terminal)"
echo -e "${GREEN}          '/+++ooooooooooooo/´          |  Packages:${RESET} $(get_packages)" 
echo -e "${GREEN}         ./ooosssso++osssssso+'         ------------------------------"
echo -e "${GREEN}        .oossssso-''''\ossssss+'        |  CPU:${RESET} $(get_cpu)"
echo -e "${GREEN}       -osssssso.      :ssssssso.       |  Memória:${RESET} $(get_disk)"
echo -e "${GREEN}      :osssssss/        osssso+++.      |  Ram:${RESET} $(get_mem)"
echo -e "${GREEN}     /ossssssss/        +ssssooo/-      ------------------------------"
echo -e "${GREEN}   '/ossssso+/:-        -:/+osssso+-    |  Uptime:${RESET} $(get_uptime)"
echo -e "${GREEN}  '+sso+:-'                 '.-/+oso:   ------------------------------"
echo -e "${GREEN} '++:.                           '-/+/  "
echo -e "${GREEN} .'                                 '+. "
echo ""
echo ""
