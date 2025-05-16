#!/bin/sh

clear
echo "====================================="
echo "     Painel Hacker - Wi-Fi Scanner"
echo "====================================="

# Detectar IP local (ignora localhost e docker)
IP=$(ip a | grep inet | grep -v 127.0.0.1 | grep -v 'docker' | awk '{print $2}' | cut -d/ -f1 | head -n 1)
REDE=$(echo "$IP" | cut -d. -f1-3).0/24

echo "[+] Seu IP: $IP"
echo "[+] Varredura da rede: $REDE"
echo ""
echo "[~] Escaneando dispositivos conectados..."

# Rodar nmap e mostrar IP + MAC + Fabricante
nmap -sn "$REDE" | awk '
/Nmap scan report/{ip=$5}
/MAC Address: /{mac=$3; vendor=""; for(i=4;i<=NF;++i) vendor=vendor" "$i; printf "IP: %-15s  MAC: %-17s  %s\n", ip, mac, vendor}
'

TOTAL=$(nmap -sn "$REDE" | grep 'Nmap scan report' | wc -l)

echo ""
echo "====================================="
echo " Total: $TOTAL dispositivos encontrados"
echo "====================================="
