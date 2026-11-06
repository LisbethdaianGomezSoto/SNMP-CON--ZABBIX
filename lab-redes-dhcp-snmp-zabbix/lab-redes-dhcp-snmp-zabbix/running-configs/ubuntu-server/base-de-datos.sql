-- Base de datos de Zabbix (MySQL 8.0)
-- Ejecutar con:  sudo mysql < base-de-datos.sql
-- Sustituye <CONTRASENA> por la contrasena elegida.

create database zabbix character set utf8mb4 collate utf8mb4_bin;
create user zabbix@localhost identified by '<CONTRASENA>';
grant all privileges on zabbix.* to zabbix@localhost;
set global log_bin_trust_function_creators = 1;

-- Despues de importar el esquema:
--   zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
-- restablecer:
set global log_bin_trust_function_creators = 0;
