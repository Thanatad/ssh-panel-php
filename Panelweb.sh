#!/bin/bash
barra="\033[0m\e[34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
[[ ! -e /bin/ipw ]] && echo "/root/Panelweb.sh" >/bin/ipw && chmod +x /bin/ipw #ACCESO RAPIDO
fun_bar() {
    comando[0]="$1"
    comando[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${comando[0]} >/dev/null 2>&1
        ${comando[1]} >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[1;33mWAIT \033[1;37m- \033[1;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[1;31m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[1;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[1;33mWAIT \033[1;37m- \033[1;33m["
    done
    echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}
IP=$(cat /etc/IP)
x="ok"
menu() {
    panel() {
        wget https://raw.githubusercontent.com/-/install >/dev/null 2>&1
        chmod +x install
        ./install
    }

    clean_folder() {
        echo ""
        fun_bar "apt-get update -y"
        fun_bar "apt-get upgrade -y"
        fun_bar "service ssh restart"

        rm -rf $HOME/install*
        rm -rf $HOME/install.sh*
        rm -rf $HOME/Painel.sh*
        rm -rf $HOME/Panel.sql*
        rm -rf $HOME/Panelweb.sh* >/dev/null 2>&1
        wget https://raw.githubusercontent.com/-/Panelweb.sh >/dev/null 2>&1
        echo ""
        echo -e "\033[1;33m CLEAN FOLDER SUCCESSFULLY -\033[1;32m OK !\033[1;37m"
        sleep 4s
        chmod +x Panelweb.sh
        ./Panelweb.sh
    }

    remove_panel() {
        clear
        echo ""
        echo -e "\033[1;36mUNINSTALL WEB PANEL"
        echo ""
        echo -ne "\033[1;37mUninstall MySQL [N/Y]: \033[1;37m"
        read x
        [[ $x = @(n|N) ]] && exit
        ##sudo
        apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
        rm -rf /etc/mysql /var/lib/mysql
        apt-get autoremove
        apt-get autoclean
        service apache2 restart
        echo ""
        echo -e "\033[1;36mPANEL SUCCESSFULLY DELETED -\033[1;32m OK !\033[1;37m"
        echo ""
        sleep 4s
        chmod +x Panelweb.sh
        ./Panelweb.sh
    }
    #SYSTEM OPTIONS
    atualizar() {
        echo ""
        fun_bar "apt-get update -y"
        fun_bar "apt-get upgrade -y"
        fun_att() {
            service ssh restart >/dev/null 2>&1
            rm -rf $HOME/Panelweb.sh* >/dev/null 2>&1
            wget https://raw.githubusercontent.com/-/Panelweb.sh >/dev/null 2>&1
        }
        fun_bar 'fun_att'
        echo ""
        echo -e "\033[1;33m SUCCESSFUL UPDATE -\033[1;32m OK !\033[1;37m"
        sleep 4s
        chmod +x Panelweb.sh
        ./Panelweb.sh
    }
    remove_multiscripts() {
        rm -rf $HOME/Panelweb.sh* && rm -rf /bin/ipw
    }

    while true $x != "ok"; do
        _usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
        _usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
        clear
        echo -e "$barra"
        echo -e "\E[41;1;37mINSTALL RESALE SSH PANEL       \033[1;32m[\033[1;37m  VERSION: r002 \033[1;32m]\E[0m"
        echo -e "$barra"
        echo ""
        echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mPANEL VIP-VPS SSH           \033[1;32m(ADE) "
        echo -e "\033[1;31m[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mCLEAN FOLDER                 \033[1;36m(\033[1;31mUNSTABLE\033[1;36m) \033[1;37m• "
        echo -e "\033[1;31m[\033[1;36m03\033[1;31m] \033[1;37m• \033[1;33mPANEL REMOVE                \033[1;36m(\033[1;31mUNSTABLE\033[1;36m) \033[1;37m• "
        echo -e "\033[1;31m[\033[1;36m04\033[1;31m] \033[1;35m[!] \033[1;32mUPDATE                \033[1;31mRam:\033[1;37m $_usor "
        echo -e "\033[1;31m[\033[1;36m05\033[1;31m] \033[1;35m[!] \033[1;31mUNINSTALL \033[1;35m[\033[1;37m IPW \033[1;35m]       \033[1;31mCpu:\033[1;37m $_usop "
        echo -e "\033[1;31m[\033[1;36m00\033[1;31m] \033[1;37mSALIR \033[1;32m<\033[1;33m<\033[1;31m< \033[0m"
        echo -e "                           \033[1;37mCYOX.GA\033[0m \033[0m"
        echo -e "$barra"
        echo ""
        echo -ne "\033[1;32mWHAT DO YOU WANT TO DO \033[1;33m?\033[1;31m?\033[1;37m : "
        read x

        case "$x" in
        1 | 01)
            clear
            panel
            exit
            ;;
        2 | 02)
            clear
            clean_folder
            exit
            ;;
        3 | 03)
            clear
            remove_panel
            exit
            ;;
        4 | 04)
            clear
            atualizar
            exit
            ;;
        5 | 05)
            clear
            remove_multiscripts
            exit
            ;;
        0 | 00)
            echo -e "\033[1;31mGoing out...\033[0m"
            sleep 2
            clear
            exit
            ;;
        *)
            echo -e "\n\033[1;31mInvalid option !\033[0m"
            ;;
        esac
    done
}
menu
#fim
