#!/bin/sh
# Hyprland Keybindings - Zenity (100% Wayland)

TITLE="Hyprland Keybindings"
export XDG_CURRENT_DESKTOP=Hyprland

show_keybinds() {
    zenity --info \
        --title="$TITLE" \
        --width=800 \
        --height=500 \
        --text="<b>🚀  (Win) Keybindings</b>

<b>💻 Sistema:</b>
 + Q     → Fechar janela
 + Tab   → Alternar workspace  
 + B     → Reiniciar Waybar
 + Shift+B → hyprctl reload
 + Shift+M → Sair do Hyprland

<b>🪟 Apps:</b>
 + T     → kitty (Terminal)
 + D     → dolphin (Files)
 + R     → rofi (Menu)
 + V     → cliphist
 + O     → VSCode config
 + Shift+O → nano config

<b>🖥 Display:</b>
 + F     → Fullscreen (com Waybar)
 + Shift+F → Fullscreen (sem Waybar)
 + F2    → Brilho -10%
 + F3    → Brilho +10%
 + F10   → Screenshot

<b>🎵 Mídia:</b>
 + F6    → Música anterior
 + F7    → Play/Pause
 + F8    → Próxima música
 + Alt+↑ → Volume +
 + Alt+↓ → Volume -

<b>Pressione ESC ou aguarde 45s</b>" \
        --ok-label="Fechar"
}

show_keybinds