# 🎯 01 · Propósito y objetivos

[← Volver al README](../README.md) · [Siguiente: Plan de direccionamiento →](02-plan-de-direccionamiento.md)

---

## Propósito del laboratorio

Implementar y validar un sistema de **monitoreo de red basado en SNMP** en una LAN virtual:

- un **router Cisco (R1)** que entrega direcciones IP por **DHCP**;
- el router y dos **switches (SW1 y SW2)** que exponen información de gestión por **SNMP v2c con una comunidad de solo lectura**;
- un **servidor Ubuntu con Zabbix**, configurado como **cliente DHCP**, que consulta a los tres equipos para **verificar los datos SNMP**.

La práctica reúne tres servicios de red que se usan juntos en una red real: **direccionamiento dinámico (DHCP)**, **gestión de dispositivos (SNMP)** y **monitoreo centralizado (Zabbix)**.

---

## Requisitos del laboratorio

**Router y switches**

- Direccionamiento IP.
- Servidor DHCP para la red LAN.
- Comunidad SNMP de solo lectura.

**Servidor Zabbix**

- Cliente DHCP.
- Verificar los datos SNMP en Zabbix del router y los switches.

**Entrega**

- Toda la documentación profesional se sube al repositorio.
- El video demostrativo está al principio del repositorio.
- La documentación tiene imágenes y diagramas, e indica el propósito del laboratorio.
- Todo script utilizado y los running-configs están en el repositorio.

---

## Objetivos específicos

| # | Objetivo | Dónde se cumple |
|:-:|---|---|
| 1 | Configurar el direccionamiento IP de R1, SW1 y SW2 | [README](../README.md#-direccionamiento-ip-del-router-y-los-switches) · [`scripts/cisco`](../scripts/cisco) |
| 2 | Configurar R1 como servidor DHCP de la LAN | [README](../README.md#-servidor-dhcp-para-la-lan) |
| 3 | Habilitar una comunidad SNMP de solo lectura en los tres equipos | [README](../README.md#-comunidad-snmp-de-solo-lectura) |
| 4 | Dejar el servidor Zabbix como cliente DHCP | [README](../README.md#-zabbix-como-cliente-dhcp) |
| 5 | Registrar los equipos en Zabbix y verificar sus datos SNMP | [README](../README.md#-verificación-de-datos-snmp-en-zabbix) |
| 6 | Comprobar la seguridad de la comunidad: lectura, escritura rechazada y comunidad incorrecta | [README](../README.md#-comunidad-snmp-de-solo-lectura) |

---

## Qué se espera ver al terminar

| Resultado | Evidencia |
|---|---|
| R1, SW1 y SW2 con su dirección IP activa | `show ip interface brief` |
| El servidor con una IP entregada por R1 | `ip -4 addr show ens33` · `show ip dhcp binding` |
| Los tres equipos responden a una consulta SNMP de lectura | `snmpget` |
| Los tres equipos rechazan una escritura | `snmpset` → `noAccess` |
| Zabbix muestra los tres equipos con SNMP disponible y sus datos | Lista de equipos · Datos más recientes |

---

## Alcance y limitaciones

- La comunidad SNMP v2c viaja en **texto claro**. Es adecuada para un laboratorio; en producción conviene **SNMPv3** y una ACL (ver [`05-conceptos-snmp.md`](05-conceptos-snmp.md#seguridad)).
- Los equipos son **virtuales**: algunos elementos de hardware (modelo y número de serie) no están disponibles por SNMP.
- La dirección del servidor Zabbix la asigna R1 de forma dinámica y puede variar entre reinicios.

---

[← Volver al README](../README.md) · [Siguiente: Plan de direccionamiento →](02-plan-de-direccionamiento.md)
