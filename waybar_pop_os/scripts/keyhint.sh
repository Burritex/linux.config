#!/bin/sh

TITLE="Pop Os Keybindings"
export XDG_CURRENT_DESKTOP=Hyprland

zenity --list \
  --title="$TITLE" \
  --width=900 \
  --height=600 \
  --text="Atalhos e ações" \
  --hide-header \
  --column="Atalho" \
  --column="Ação" \
  "Binds" "" \
  " + Tab" "Alternar workspace" \
  " + Q"   "Fechar janela" \
  " + T"   "kitty (Terminal)" \
  " + F"   "Fullscreen" \
  "Waybar Modules" "" \
  " CPU /  RAM · left click" "htop" \
  " Data · left click" "Visual alternativo" \
  " Data · right click" "Calendario Google" \
  " Data · middle click" "Alterna tooltip" \
  "󰥔 Hora · left click" "Visual alternativo" \
  " Bluetooth · left click" "blueman-manager" \
  " Bluetooth · right click" "Ativar/desativar" \
  "  Audio · left click" "Mutar" \
  "  Audio · right click" "pavucontrol" \
  "󰤨 Rede · left click" "nm-connection-editor" \
  "󰤨 Rede · right click" "nmtui" \
  "󱄄 Brilho · left click" "Mais 10%" \
  "󱄄 Brilho · right click" "Menos 10%" \
  "󱄄 Brilho · middle click" "80%"