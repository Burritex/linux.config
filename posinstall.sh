#!/bin/bash

#CORES
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'


# -------------------------------TESTES E REQUISITOS----------------------------------------- #
# Internet conectando?
testes_internet(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente.${SEM_COR}"
fi
}

## Atualizando Sistema ##
att_system_void(){
    echo -e "${VERDE}[INFO] - Atualizando repositórios e pacotes...${SEM_COR}"
    if ! sudo xbps-install -Suy; then
        echo -e "${VERMELHO}[ERROR] - Falha ao atualizar o sistema.${SEM_COR}"
        exit 1
    fi
}

## Instalando pacotes Flatpak ##
install_flatpaks(){

    # instalar flatpak
    echo "Baixando flatpak"
    if ! xbps-install -Sy flatpak
    then
        echo "Falha ao instalar o flatpak"
        exit 1
    fi
    echo "${VERDE}Flatpak instalado com sucesso${SEM_COR}"
    echo -e "${VERDE}[INFO] - Instalando pacotes flatpak${SEM_COR}"

    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub com.google.Chrome -y
    flatpak install flathub org.flameshot.Flameshot -y
}

## VoidLinux ##
programas_para_instalar_void=(
    "git"
    "wget"
    "leafpad"
    "kitty"
    "vscode"
    "xorg"
    "mesa" 
    "NetworkManager" 
    "nano"
    "xdg-user-dirs" 
    "zsh"
    "nerd-fonts-ttf" 
    "google-fonts-ttf" 
    "blueman" 
    "bluez" 
    "pipewire" 
    "alsa-pipewire" 
    "libjack-pipewire" 
    "wireplumber"
    "pulseaudio" 
    "pulseaudio-utils"
    "gst-libav" 
    "gst-plugins-base1" 
    "gst-plugins-bad1" 
    "gst-plugins-good1" 
    "gst-plugins-ugly1" 
    "ffmpeg"
    "xdg-desktop-portal" 
    "xdg-desktop-portal-gtk"
    "breeze" 
    "breeze-gtk" 
    "papirus-icon-theme" 
    "nwg-look"
    "pamixer" 
    "pavucontrol"
    "xdg-user-dirs"
)

servicos_para_iniciar_void=(
    "NetworkManager"
    "bluetoothd"
)

## ArchLinux ##
programas_para_instalar_arch=(
    "pipewire" 
    "pipewire-alsa" 
    "pipewire-jack" 
    "pipewire-pulse" 
    "wireplumber" 
    "gstreamer" 
    "gst-libav" 
    "gst-plugins-base" 
    "gst-plugins-good" 
    "gst-plugins-bad" 
    "gst-plugins-ugly" 
    "ffmpeg"
    "kitty"
    "xdg-desktop-portal-gtk"
    "pavucontrol" 
    "xdg-user-dirs-gtk" 
    "ttf-font-awesome" 
    "ttf-jetbrains-mono-nerd"
    "breeze" 
    "breeze5" 
    "breeze-gtk" 
    "papirus-icon-theme" 
    "nwg-look" 
    "networkmanager" 
    "blueman"
    "zsh"
    "git"
)

instalando_aur_yay(){

}

servicos_para_iniciar_arch=( 
    "pipewire" 
    "pipewire-pulse" 
    "wireplumber" 
    "pacseek" 
    "bluetooth.service" 
    "NetworkManager.service"
)

## Habilitando serviços ##
habilitando_servicos(){
        echo -e "${VERDE}[INFO] - Habilitando Serviços${SEM_COR}"

    case "$distro" in
        void)
            ## Runit ##

            for nome_servico in "${servicos_para_iniciar[@]}"; do
                if [ -L /var/service/"$nome_servico" ]; then
                    echo -e "${VERDE}[JÁ HABILITADO] - $nome_servico${SEM_COR}"
                elif [ ! -d /etc/sv/"$nome_servico" ]; then
                    echo -e "${VERMELHO}[ERROR] - Serviço $nome_servico não encontrado em /etc/sv/${SEM_COR}"
                else
                    if sudo ln -s /etc/sv/"$nome_servico" /var/service/; then
                        echo -e "${VERDE}[INFO] - Serviço $nome_servico habilitado${SEM_COR}"
                    else
                        echo -e "${VERMELHO}[ERROR] - Falha ao habilitar $nome_servico${SEM_COR}"
                    fi
                fi
            done
        ;;
        *)
            ## Systemctl ##
            for nome_servico in "${servicos_para_iniciar[@]}"; do
                if systemctl is-enabled --quiet "$nome_servico" 2>/dev/null; then
                    echo -e "${VERDE}[JÁ HABILITADO] - $nome_servico${SEM_COR}"
                else
                    if sudo systemctl enable "$nome_servico"; then
                        echo -e "${VERDE}[INFO] - Serviço $nome_servico habilitado${SEM_COR}"
                    else
                        echo -e "${VERMELHO}[ERROR] - Falha ao habilitar $nome_servico${SEM_COR}"
                    fi
                fi
            done
        ;;
    esac
}

## Instalando pacotes via xbps ##
instalando_programas(){
    echo -e "${VERDE}[INFO] - Instalando pacotes xbps${SEM_COR}"

    for nome_do_programa in "${programas_para_instalar[@]}"; do
        if xbps-query -l | grep -q " ${nome_do_programa}-"; then
            echo -e "${VERDE}[INSTALADO] - ${nome_do_programa}${SEM_COR}"
        else
            echo -e "${VERDE}[INFO] - Instalando ${nome_do_programa}...${SEM_COR}"
            if ! sudo xbps-install -Sy "$nome_do_programa"; then
                echo -e "${VERMELHO}[ERROR] - Falha ao instalar ${nome_do_programa}${SEM_COR}"
            fi
        fi
    done
}

criar_diretorios_usuario(){
    echo -e "${VERDE}[INFO] - Criando diretórios padrão do usuário${SEM_COR}"
    xdg-user-dirs-update
}

# -------------------------------EXECUÇÃO----------------------------------------- #
testes_internet
att_system
install_flatpaks
instalando_programas
habilitando_servicos
criar_diretorios_usuario
