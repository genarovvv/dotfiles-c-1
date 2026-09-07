#!/bin/sh
# network.sh — Muestra solo [ICONO] [IP], priorizando VPN > WiFi > Ethernet

get_ip() {
    ip -4 -o addr show "$1" up 2>/dev/null | awk '{print $4}' | cut -d/ -f1
}

# --- VPN ---
for vpn_if in tun0 tun1 wg0 wg1 ppp0 tap0; do
    ip=$(get_ip "$vpn_if")
    [ -n "$ip" ] && echo "󰦝 ${ip}" && exit 0
done
vpn_iface=$(ip -o link show | awk -F': ' '{print $2}' | grep -E '^(tun|wg|ppp)[0-9]*$' | head -n1)
if [ -n "$vpn_iface" ]; then
    ip=$(get_ip "$vpn_iface")
    [ -n "$ip" ] && echo "󰦝 ${ip}" && exit 0
fi

# --- WiFi ---
wifi_iface=$(ip -o link show | awk -F': ' '{print $2}' | grep -E '^(wlan[0-9]*|wl[a-z0-9]*)$' | head -n1)
if [ -n "$wifi_iface" ]; then
    ip=$(get_ip "$wifi_iface")
    [ -n "$ip" ] && echo " ${ip}" && exit 0
fi

# --- Ethernet ---
eth_iface=$(ip -o link show | awk -F': ' '{print $2}' | grep -E '^(eth[0-9]*|en[a-z0-9]*)$' | head -n1)
if [ -n "$eth_iface" ]; then
    ip=$(get_ip "$eth_iface")
    [ -n "$ip" ] && echo "󰈀 ${ip}" && exit 0
fi

# --- Nada conectado ---
echo " Desconectado"
exit 0
