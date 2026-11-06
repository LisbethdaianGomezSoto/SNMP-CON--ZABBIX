#!/usr/bin/env bash
# =============================================================================
# 02_configurar_bd_zabbix.sh
# Crea la base de datos de Zabbix, importa el esquema, fija DBPassword en
# /etc/zabbix/zabbix_server.conf y arranca los servicios.
#
# Ejecutar con:  sudo bash 02_configurar_bd_zabbix.sh
# La contraseña se pide al ejecutar y no queda guardada en el script.
# (Evita usar comillas simples en la contraseña.)
# =============================================================================
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Ejecuta este script con sudo." >&2
  exit 1
fi

read -r -s -p "Contraseña para el usuario 'zabbix' de MySQL: " DB_PASS
echo
if [[ -z "${DB_PASS}" ]]; then
  echo "La contraseña no puede estar vacía." >&2
  exit 1
fi

CONF="/etc/zabbix/zabbix_server.conf"

echo "[1/5] Creando la base de datos y el usuario"
mysql <<SQL
create database if not exists zabbix character set utf8mb4 collate utf8mb4_bin;
create user if not exists 'zabbix'@'localhost' identified by '${DB_PASS}';
alter user 'zabbix'@'localhost' identified by '${DB_PASS}';
grant all privileges on zabbix.* to 'zabbix'@'localhost';
set global log_bin_trust_function_creators = 1;
SQL

echo "[2/5] Importando el esquema inicial (puede tardar unos minutos)"
YA_IMPORTADO=$(MYSQL_PWD="${DB_PASS}" mysql -uzabbix -N -e \
  "select count(*) from information_schema.tables where table_schema='zabbix' and table_name='dbversion';")
if [[ "${YA_IMPORTADO}" == "1" ]]; then
  echo "     El esquema ya estaba importado; se omite."
else
  zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz \
    | MYSQL_PWD="${DB_PASS}" mysql --default-character-set=utf8mb4 -uzabbix zabbix
fi

echo "[3/5] Restableciendo log_bin_trust_function_creators"
mysql -e "set global log_bin_trust_function_creators = 0;"

echo "[4/5] Fijando DBPassword en ${CONF}"
sed -i '/^# \?DBPassword=/d;/^DBPassword=/d' "${CONF}"
printf 'DBPassword=%s\n' "${DB_PASS}" >> "${CONF}"

echo "[5/5] Habilitando e iniciando los servicios"
systemctl restart zabbix-server zabbix-agent2 apache2
systemctl enable zabbix-server zabbix-agent2 apache2 >/dev/null

echo
systemctl --no-pager --lines=0 status zabbix-server | head -n 4
echo
echo "Listo. Abre http://IP_DEL_SERVIDOR/zabbix desde la PC y completa el asistente."
