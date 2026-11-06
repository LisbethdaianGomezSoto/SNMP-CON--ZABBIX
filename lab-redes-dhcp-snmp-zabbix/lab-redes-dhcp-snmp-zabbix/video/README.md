# 🎬 Video demostrativo

El video está enlazado al inicio del [README principal](../README.md).

## Guion de la demostración

| # | Qué se muestra | Dónde |
|:-:|---|---|
| 1 | Topología en GNS3: R1, SW1, SW2, servidor Zabbix y PC | GNS3 |
| 2 | Direccionamiento: `show ip interface brief` en R1, SW1 y SW2 | Consolas Cisco |
| 3 | Servidor DHCP: `show running-config \| section dhcp` y `show ip dhcp binding` | R1 |
| 4 | El servidor como cliente DHCP: `ip -4 addr show ens33` y `networkctl status ens33` | Ubuntu Server |
| 5 | SNMP de solo lectura: `show running-config \| include snmp` | R1, SW1 y SW2 |
| 6 | Lectura correcta: `snmpget` a los tres equipos | Ubuntu Server |
| 7 | Escritura rechazada: `snmpset` → `noAccess`, y `sysLocation` sin cambios | Ubuntu Server |
| 8 | Comunidad incorrecta: `snmpget` con `otra` → `Timeout` | Ubuntu Server |
| 9 | Zabbix: lista de equipos con SNMP disponible | Navegador de la PC |
| 10 | Zabbix: *Datos más recientes* de R1, SW1 y SW2 (filtro `System`) | Navegador de la PC |
| 11 | Zabbix: interfaces y tráfico (`Bits received`) | Navegador de la PC |

## Comandos de apoyo

Los comandos de cada paso están en [`../scripts/`](../scripts):

- Cisco: [`cisco/verificacion.txt`](../scripts/cisco/verificacion.txt)
- Servidor: [`04_verificar_snmp.sh`](../scripts/04_verificar_snmp.sh) y [`05_evidencias_cliente_dhcp.sh`](../scripts/05_evidencias_cliente_dhcp.sh)

## Publicar el enlace

En el README principal, reemplaza `REEMPLAZAR_ID_DEL_VIDEO` en esta línea:

```markdown
[![Ver el video demostrativo](docs/assets/video-placeholder.svg)](https://youtu.be/REEMPLAZAR_ID_DEL_VIDEO)
```
