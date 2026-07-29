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
att_system(){
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

programas_para_instalar=(
    "git"
    "wget"
    "leafpad"
    "kitty"
    "vscode"
)

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

# -------------------------------EXECUÇÃO----------------------------------------- #
testes_internet
att_system
install_flatpaks
instalando_programas
