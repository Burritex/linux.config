#!/bin/sh
# Hyprland Keybindings List

export QT_QPA_PLATFORM=xcb
export GDK_BACKEND=x11
export XDG_CURRENT_DESKTOP=Hyprland


yad --width=900 --height=650 \
    --center \
    --fixed \
    --title="Hyprland Keybindings" \
    --no-buttons \
    --list \
    --column="Key:" \
    --column="Description:" \
    --column="Command:" \
    --timeout=60 \
    --timeout-indicator=right \
    "ESC" "close this app" "" \
    "=" "modkey" "(set mod Mod4)" \
    "+t" "Terminal" "(kitty)" \
    "+q" "" "Fecha janela ativa" \
    "+d" "" "(dolphin)" \
    "+r" "Application Menu" "(rofi)" \
    "+v" "cliphist" "historico do ctrl+c" \
    "+f" "Fullscreen 1" "Tela cheia com waybar" \
    "+o" "󰨞 " "Arquivo de configuração do hyprland via vscode" \
    "+b" "󰑓 " "Reinicia a waybar" \
    "+Tab" "󰍺" "Change active workspace" \
    "+f2" "󱀦" "-10% de Brilho" \
    "+f3" "󰡫" "+10% de Brilho" \
    "+f6" " 󰎆" "previous" \
    "+f7" "󰐎 󰎆" "pause/play" \
    "+f8" " 󰎆" "next" \
    "+f10" "󰄀 󰍹" "Printscreen" \
    "+Alt+" "󰝝" "Volume ++" \
    "+Alt+" "󰝞" "Volume --" \
    "+Shift+b" "󰑓 " "Reinicia o hyprctl" \
    "+Shift+C" "" "Change wallpaper" \
    "+Shift+f" "Fullscreen" "Tela cheia sem waybar" \
    "+Shift+o" "" "Arquivo de configuração do hyprland via nano" \
    "+Shift+m" "Exit" "Sai do hyprland" 
