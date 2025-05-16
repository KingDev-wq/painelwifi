#!/bin/sh
clear
echo "====================================="
echo "     Painel Hacker - Wi-Fi Scanner"
echo "====================================="
echo ""
echo "[~] Detectando seu IP local..."

IP=$(ip addr | grep inet | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1)
REDE=$(echo $IP | cut -d. -f1-3).0/24

echo "[+] Seu IP: $IP"
echo "[+] Varredura da rede: $REDE"
echo ""
echo "[~] Escaneando dispositivos conectados..."

nmap -sn $REDE | grep -E 'Nmap scan report|MAC Address' | sed 's/Nmap scan report for //g' | sed 's/MAC Address: //g' | awk 'NR%2{printf "IP: %-15s  ", $0; next}1' | sed 's/\t/  /g'

echo ""
echo "====================================="
echo " Total: $(nmap -sn $REDE | grep 'Nmap scan report' | wc -l) dispositivos encontrados"
echo "====================================="
