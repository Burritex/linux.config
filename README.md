# linux.config
My linux .config

## Void-Linux (sway)

### Packages:
```     
	sudo xbps-install -S xorg mesa zsh NetworkManager nano git xdg-user-dirs zsh nerd-fonts-ttf google-fonts-ttf blueman bluez pipewire alsa-pipewire libjack-pipewire wireplumber kitty firefox sway rofi pulseaudio pulseaudio-utils Waybar mako gst-libav gst-plugins-base1 gst-plugins-bad1 gst-plugins-good1 gst-plugins-ugly1 ffmpeg kio-admin polkit-kde-agent qt5-wayland qt6-wayland xdg-desktop-portal xdg-desktop-portal-gtk dunst cliphist mpv gnome-keyring breeze breeze-gtk papirus-icon-theme nwg-look kde-cli-tools
```

### Habilitanto serviços:
	- Pulseaudio: ` pulseaudio --start --log-target=syslog`


## Arch-Linux (hyprland)

### Packages:
```
	sudo pacman -Sy pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber gstreamer gst-libav gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly ffmpeg git hyprland hyprlock hypridle hyprcursor hyprpaper hyprpicker waybar kitty rofi-wayland dolphin dolphin-plugins ark kio-admin polkit-kde-agent qt5-wayland qt6-wayland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk dunst cliphist mpv pavucontrol xdg-user-dirs-gtk ttf-font-awesome ttf-jetbrains-mono-nerd  gnome-keyring fastfetch breeze breeze5 breeze-gtk papirus-icon-theme nwg-look kde-cli-tools archlinux-xdg-menu networkmanager blueman
```

- AUR Packages:
```
	yay -Sy --noconfirm hyprshot wlogout qview visual-studio-code-bin brave-bin qt5ct-kde qt6ct-kde zsh gufw zenity nwg-drawer blueman pamixer wpaperd
```

- AUR Instalation
```
	git clone https://aur.archlinux.org/yay 
	cd yay 
	makepkg -si
```

### Habilitanto serviços:
```
	systemctl --user enable pipewire pipewire-pulse wireplumber pacseek
	systemctl enable bluetooth.service --now
	sudo systemctl enable NetworkManager.service --now
```