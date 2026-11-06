#!/usr/bin/env bash
# =============================================================================
# 01_instalar_zabbix.sh
# Instala Zabbix 7.0 LTS (servidor, interfaz web y agente 2) con MySQL
# en Ubuntu Server 24.04.
#
# Requisitos: salida a internet. Ejecutar con:  sudo bash 01_instalar_zabbix.sh
# =============================================================================
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Ejecuta este script con sudo." >&2
  exit 1
fi

ZBX_REPO_DEB="zabbix-release_latest_7.0+ubuntu24.04_all.deb"
ZBX_REPO_URL="https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/${ZBX_REPO_DEB}"

echo "[1/4] Actualizando el índice de paquetes"
apt-get update

echo "[2/4] Instalando MySQL Server"
DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

echo "[3/4] Agregando el repositorio oficial de Zabbix 7.0"
cd /tmp
wget -q "${ZBX_REPO_URL}" -O "${ZBX_REPO_DEB}"
dpkg -i "${ZBX_REPO_DEB}"
apt-get update

echo "[4/4] Instalando los paquetes de Zabbix"
apt-get install -y \
  zabbix-server-mysql \
  zabbix-frontend-php \
  zabbix-apache-conf \
  zabbix-sql-scripts \
  zabbix-agent2 \
  snmp

echo
echo "Listo. Siguiente paso: sudo bash 02_configurar_bd_zabbix.sh"
