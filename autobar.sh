#!/usr/bin/env bash

clear
function menu() {
    echo -e ' **** Polybar minimalista para o ArchLinux / i3wm ****\n'

    echo -n ''' AVISO: Esse script baixa e instala pacotes do AUR.
        Sendo assim, só inicie se estiver ciente dos riscos.
           
:: Deseja iniciar o script agora? [S/n] '''
    read opc
}

function fim() {
    clear
    echo -e ':: [Passo 8] O sistema precisa ser reinicializado para aplicar as mudanças...\n'
    echo -n ':: Deseja reiniciar o sistema agora? [S/n] '
    read reboot

    case $reboot in
    s | S | "")
        clear
        echo ':: Reiniciando...'
        sleep 3
        reboot
        ;;
    n | N)
        clear
        echo ':: Saindo...'
        sleep 3
        exit
        clear
        ;;
    *)
        echo '''Opção Inválida
             :: Saindo...'''
        sleep 3
        exit
        clear
        ;;
    esac
}

menu
case $opc in
s | S | "")
    clear
    echo -e ':: [Passo 1] O sistema será atualizado...\n'
    sleep 3
    sudo pacman -Syyu --noconfirm
    clear
    echo -e ':: [Passo 2] As dependências serão instaladas...\n'
    sleep 3
    sudo pacman -S git wget --noconfirm
    clear
    echo -e ':: [Passo 3] Baixando polybar...\n'
    sleep 3
    sudo wget -P ~/Downloads https://aur.archlinux.org/cgit/aur.git/snapshot/polybar.tar.gz
    clear
    echo -e ':: [Passo 4]:: Descompactando polybar...\n'
    sleep 3
    cd ~/Downloads
    tar -xvf polybar.tar.gz
    cd ~/Downloads/polybar
    clear
    echo -e ':: [Passo 5] Compilando e instalando polybar...\n'
    sleep 3
    makepkg -si --noconfirm
    rm -r polybar polybar.tar.gz
    clear
    echo -e ':: [Passo 6] Baixando e instalando fontes necessárias...\n'
    sleep 3
    cd ~/Downloads
    git clone https://github.com/powerline/fonts.git
    cd ~/Downloads/fonts
    ./install.sh
    clear
    echo -e ':: [Passo 7] Baixando arquivo de configuração...\n'
    sleep 3
    cd ~/Downloads
    wget -P ~/Downloads https://raw.githubusercontent.com/Lavrudin/My-preset/master/polybar-config
    mv polybar-config config
    clear
    echo -e ':: [Passo 8] Configurando...'
    sleep 3
    mkdir -p ~/.config/polybar
    cp ~/Downloads/config ~/.config/polybar
    echo -e '\nexec --no-startup-id polybar -r mybar' >>~/.config/i3/config
    fim
    ;;
n | N)
    clear
    echo ':: Saindo...'
    sleep 3
    clear
    exit
    ;;
*)
    echo -e '\n Opção Inválida'
    sleep 3
    clear
    menu
    ;;
esac
