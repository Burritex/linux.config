#!/bin/bash

#CORES
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'


## Programas para instalar ##
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

programas_para_instalar_apt=(
    "kitty"
)

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
    "base-devel"
)

programas_para_instalar_aur=(
    "pacseek"
)

## Serviços para iniciar ##
servicos_para_iniciar_void=(
    "NetworkManager"
    "bluetoothd"
)

servicos_para_iniciar_arch=( 
    "pipewire" 
    "pipewire-pulse" 
    "wireplumber" 
    "bluetooth.service" 
    "NetworkManager.service"
)

servicos_para_iniciar_apt=(

)

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
atualizar_sistema(){
    echo -e "${VERDE}[INFO] - Atualizando repositórios e pacotes...${SEM_COR}"

    case $DISTRO in
        void)
            if ! sudo xbps-install -Suy; then
                echo -e "${VERMELHO}[ERROR] - Falha ao atualizar o sistema.${SEM_COR}"
                exit 1
            fi
        ;;
        arch)
            if ! sudo pacman -Syu --noconfirm; then
                echo -e "${VERMELHO}[ERROR] - Falha ao atualizar o sistema.${SEM_COR}"
                exit 1
            fi
        ;;
        *)
            if ! sudo apt update; then
                echo -e "${VERMELHO}[ERROR] - Falha ao atualizar repositórios.${SEM_COR}"
                exit 1
            fi
            if ! sudo apt upgrade -y; then
                echo -e "${VERMELHO}[ERROR] - Falha ao atualizar pacotes.${SEM_COR}"
                exit 1
            fi
        ;;
    esac
}

## Instalando pacotes Flatpak ##
instalar_flatpak_binario(){
    case "$DISTRO" in
        void)
            sudo xbps-install -Sy flatpak
        ;;
        arch)
            sudo pacman -S --noconfirm flatpak
        ;;
        *)
            sudo apt install -y flatpak
        ;;
    esac
}

install_flatpaks(){
    echo -e "${VERDE}[INFO] - Instalando flatpak...${SEM_COR}"
    if ! instalar_flatpak_binario; then
        echo -e "${VERMELHO}[ERROR] - Falha ao instalar o flatpak${SEM_COR}"
        exit 1
    fi
    echo -e "${VERDE}[INFO] - Flatpak instalado com sucesso${SEM_COR}"

    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    FLATPAKS=("com.google.Chrome" "org.flameshot.Flameshot")
    for app in "${FLATPAKS[@]}"; do
        if ! flatpak install flathub "$app" -y; then
            echo -e "${VERMELHO}[ERROR] - Falha ao instalar $app${SEM_COR}"
        fi
    done
}

instalar_yay(){
    echo -e "${VERDE}[INFO] - Verificando yay...${SEM_COR}"

    if command -v yay &> /dev/null; then
        echo -e "${VERDE}[JÁ INSTALADO] - yay${SEM_COR}"
        return 0
    fi

    echo -e "${VERDE}[INFO] - Instalando dependências (git, base-devel)...${SEM_COR}"
    if ! sudo pacman -S --needed --noconfirm git base-devel; then
        echo -e "${VERMELHO}[ERROR] - Falha ao instalar dependências do yay${SEM_COR}"
        return 1
    fi

    local diretorio_temp
    diretorio_temp=$(mktemp -d)

    echo -e "${VERDE}[INFO] - Clonando repositório do yay...${SEM_COR}"
    if ! git clone https://aur.archlinux.org/yay.git "$diretorio_temp"; then
        echo -e "${VERMELHO}[ERROR] - Falha ao clonar o repositório do yay${SEM_COR}"
        rm -rf "$diretorio_temp"
        return 1
    fi

    echo -e "${VERDE}[INFO] - Compilando e instalando yay...${SEM_COR}"
    if (cd "$diretorio_temp" && makepkg -si --noconfirm); then
        echo -e "${VERDE}[INFO] - yay instalado com sucesso${SEM_COR}"
    else
        echo -e "${VERMELHO}[ERROR] - Falha ao compilar/instalar o yay${SEM_COR}"
        rm -rf "$diretorio_temp"
        return 1
    fi

    rm -rf "$diretorio_temp"
}


## Habilitando serviços ##
habilitando_servicos(){
        echo -e "${VERDE}[INFO] - Habilitando Serviços${SEM_COR}"

    case "$DISTRO" in
        void)
            ## Runit ##
            for nome_servico in "${servicos_para_iniciar_void[@]}"; do
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
        arch)
            ## Systemctl ##
            for nome_servico in "${servicos_para_iniciar_arch[@]}"; do
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
        *)
            for nome_servico in "${servicos_para_iniciar_apt[@]}"; do
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

    case "$DISTRO" in
        void)
            for nome_do_programa in "${programas_para_instalar_void[@]}"; do
                if xbps-query -l | grep -q " ${nome_do_programa}-"; then
                    echo -e "${VERDE}[INSTALADO] - ${nome_do_programa}${SEM_COR}"
                else
                    echo -e "${VERDE}[INFO] - Instalando ${nome_do_programa}...${SEM_COR}"
                    if ! sudo xbps-install -Sy "$nome_do_programa"; then
                        echo -e "${VERMELHO}[ERROR] - Falha ao instalar ${nome_do_programa}${SEM_COR}"
                    fi
                fi
            done
        ;;
        arch)
            for nome_do_programa in "${programas_para_instalar_arch[@]}"; do
                if pacman -Q "$nome_do_programa" &> /dev/null; then
                    echo -e "${VERDE}[INSTALADO] - ${nome_do_programa}${SEM_COR}"
                else
                    echo -e "${VERDE}[INFO] - Instalando ${nome_do_programa}...${SEM_COR}"
                    if ! sudo pacman -S --noconfirm "$nome_do_programa"; then
                        echo -e "${VERMELHO}[ERROR] - Falha ao instalar ${nome_do_programa}${SEM_COR}"
                    fi
                fi
            done
        ;;
        *)
            for nome_do_programa in "${programas_para_instalar_apt[@]}"; do
                if dpkg -l | grep -qw "$nome_do_programa"; then
                    echo -e "${VERDE}[INSTALADO] - ${nome_do_programa}${SEM_COR}"
                else
                    echo -e "${VERDE}[INFO] - Instalando ${nome_do_programa}...${SEM_COR}"
                    if ! sudo apt install -y "$nome_do_programa"; then
                        echo -e "${VERMELHO}[ERROR] - Falha ao instalar ${nome_do_programa}${SEM_COR}"
                    fi
                fi
            done
        ;;
    esac
}

instalando_programas_aur(){
    for nome_do_programa in "${programas_para_instalar_aur[@]}"; do
        if yay -Q "$nome_do_programa" &> /dev/null; then
            echo -e "${VERDE}[INSTALADO] - ${nome_do_programa}${SEM_COR}"
        else
            echo -e "${VERDE}[INFO] - Instalando ${nome_do_programa}...${SEM_COR}"
            if ! yay -S --noconfirm "$nome_do_programa"; then
                echo -e "${VERMELHO}[ERROR] - Falha ao instalar ${nome_do_programa}${SEM_COR}"
            fi
        fi
    done
}

criar_diretorios_usuario(){
    echo -e "${VERDE}[INFO] - Criando diretórios padrão do usuário${SEM_COR}"
    xdg-user-dirs-update
}

detectar_distro(){
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
        echo -e "${VERDE}[INFO] - Distro detectada: $DISTRO${SEM_COR}"
    else
        echo -e "${VERMELHO}[ERROR] - Não foi possível detectar a distribuição.${SEM_COR}"
        exit 1
    fi
}

# -------------------------------EXECUÇÃO----------------------------------------- #
testes_internet
detectar_distro
atualizar_sistema
install_flatpaks
instalando_programas

case $DISTRO in
    arch)
        instalar_yay
        instalando_programas_aur
    ;;
esac

criar_diretorios_usuario
habilitando_servicos
