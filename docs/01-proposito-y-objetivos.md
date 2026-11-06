# 🎯 01 · Propósito y objetivos

[← Volver al README](../README.md) · [Siguiente: Plan de direccionamiento →](02-plan-de-direccionamiento.md)

---

## 🎯 Propósito del Laboratorio

El presente laboratorio tiene como finalidad implementar y validar una infraestructura de **monitoreo de red basada en el protocolo SNMP** dentro de una LAN virtualizada. Para lograrlo, se integran tres servicios fundamentales que conviven en cualquier entorno de red real: el direccionamiento dinámico (**DHCP**), la gestión de dispositivos (**SNMP**) y la monitorización centralizada (**Zabbix**).

El escenario técnico se compone de un **Router Cisco (R1)** que actúa como servidor DHCP para la LAN, junto con dos **Switches (SW1 y SW2)**. Tanto el router como los switches exponen su información de gestión utilizando **SNMP v2c** con una comunidad restringida a solo lectura. Por otro lado, un **Servidor Ubuntu con Zabbix**, configurado como cliente DHCP, es el encargado de consultar y verificar los datos recolectados de los tres dispositivos de red.

---

## 🛠️ Requisitos de la Práctica

Para considerar el laboratorio como exitoso, se deben cumplir los siguientes puntos técnicos y de entrega:

**⚙️ Infraestructura de Red (Routers y Switches)**
* Configurar el direccionamiento IP base en los equipos.
* Habilitar a R1 como el servidor DHCP para los clientes de la LAN.
* Definir una comunidad SNMP con permisos estrictos de solo lectura.

**📊 Servidor de Monitoreo (Zabbix)**
* Configurar la interfaz del servidor Ubuntu para que obtenga su IP dinámicamente (DHCP).
* Integrar los dispositivos en Zabbix para verificar la correcta recepción de las métricas SNMP del router y los switches.

**📦 Criterios de Entrega**
* Documentación técnica subida al repositorio, incluyendo diagramas e imágenes del proceso.
* El video demostrativo debe estar ubicado al inicio del repositorio.
* Incluir todos los scripts de configuración utilizados, así como los archivos `running-config` de los equipos.

---

## 📌 Matriz de Objetivos y Evidencias

A continuación se detalla cómo se cumple cada objetivo y qué evidencia lo respalda:

| Nivel | Objetivo a cumplir | Evidencia Esperada |
| :--- | :--- | :--- |
| **1. Red Base** | Configurar direccionamiento IP en R1, SW1 y SW2. | Salida del comando `show ip interface brief`. |
| **2. DHCP** | R1 como servidor DHCP y Ubuntu como cliente. | Ubuntu obtiene IP (`ip -4 addr`) y R1 muestra la asignación (`show ip dhcp binding`). |
| **3. SNMP** | Habilitar comunidad de solo lectura en los 3 equipos. | Los equipos responden a `snmpget` y rechazan escrituras con `snmpset` (error `noAccess`). |
| **4. Monitoreo** | Registrar equipos en Zabbix y verificar datos. | Panel de Zabbix mostrando los equipos en verde y los datos más recientes recolectados. |

*(Nota: La seguridad de la comunidad SNMP también se comprueba intentando una escritura o usando una comunidad incorrecta).*

---

## ⚠️ Alcance y Limitaciones

Es importante reconocer las fronteras de este laboratorio:
*   **Seguridad:** SNMP v2c transmite la comunidad en texto claro. Es funcional para el laboratorio, pero en producción se debe migrar a SNMPv3 y aplicar ACLs.
*   **Virtualización:** Al ser entornos virtuales, ciertas métricas de hardware (como número de serie o modelo específico) pueden no estar disponibles vía SNMP.
*   **Red:** La IP del servidor Zabbix es dinámica (vía DHCP), por lo que la dirección asignada puede cambiar si el servidor o el router se reinician.

---
*[← Volver al README principal](../README.md) | [Siguiente sección: Plan de Direccionamiento →](02-plan-de-direccionamiento.md)*
