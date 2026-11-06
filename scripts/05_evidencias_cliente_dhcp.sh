#!/usr/bin/env bash
# =============================================================================
# 05_evidencias_cliente_dhcp.sh
# Muestra, en una sola pantalla, la evidencia de que el servidor es cliente DHCP.
#
# Uso:  bash 05_evidencias_cliente_dhcp.sh [interfaz]     (por defecto ens33)
# =============================================================================
IFACE="${1:-ens33}"

echo "== ip -4 addr show ${IFACE} =="
ip -4 addr show "${IFACE}"
echo

echo "== networkctl status ${IFACE} =="
networkctl status "${IFACE}" --no-pager
echo

echo "== /etc/netplan/50-cloud-init.yaml =="
cat /etc/netplan/50-cloud-init.yaml
echo

echo "== Historial DHCPv4 (systemd-networkd) =="
sudo journalctl -u systemd-networkd --no-pager | grep DHCPv4 | tail -n 3
