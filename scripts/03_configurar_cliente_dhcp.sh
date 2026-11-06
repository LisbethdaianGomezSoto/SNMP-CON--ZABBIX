#!/usr/bin/env bash
# =============================================================================
# 03_configurar_cliente_dhcp.sh
# Deja la interfaz de la LAN como cliente DHCP mediante netplan.
#
# Uso:  sudo bash 03_configurar_cliente_dhcp.sh [interfaz]     (por defecto ens33)
# =============================================================================
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Ejecuta este script con sudo." >&2
  exit 1
fi

IFACE="${1:-ens33}"
NETPLAN_FILE="/etc/netplan/50-cloud-init.yaml"

# Netplan lee todos los .yaml de la carpeta: avisa si hay más de uno.
OTROS=$(find /etc/netplan -maxdepth 1 -name '*.yaml' ! -name "$(basename "${NETPLAN_FILE}")" | tr '\n' ' ')
if [[ -n "${OTROS}" ]]; then
  echo "Aviso: hay otros archivos de netplan que pueden entrar en conflicto: ${OTROS}"
fi

if [[ -f "${NETPLAN_FILE}" ]]; then
  cp -a "${NETPLAN_FILE}" "${NETPLAN_FILE}.bak.$(date +%Y%m%d%H%M%S)"
fi

cat > "${NETPLAN_FILE}" <<YAML
network:
  version: 2
  ethernets:
    ${IFACE}:
      dhcp4: true
YAML
chmod 600 "${NETPLAN_FILE}"

# Evita que cloud-init vuelva a generar la configuración de red al reiniciar.
echo "network: {config: disabled}" > /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg

netplan apply
sleep 3

echo
ip -4 addr show "${IFACE}"
