#!/usr/bin/env bash
# =============================================================================
# 04_verificar_snmp.sh
# Pruebas SNMP desde el servidor Zabbix (requiere el paquete 'snmp'):
#   1) Lectura con la comunidad correcta      -> debe funcionar
#   2) Escritura con la comunidad de lectura  -> debe fallar (noAccess)
#   3) sysLocation tras el intento anterior   -> no debe haber cambiado
#   4) Lectura con una comunidad incorrecta   -> debe fallar (timeout)
#
# Uso:  bash 04_verificar_snmp.sh
# =============================================================================
COMUNIDAD="ZBX_RO"
COMUNIDAD_INVALIDA="otra"
EQUIPOS=("R1:10.7.1.1" "SW1:10.7.1.2" "SW2:10.7.1.3")

OID_SYSNAME="1.3.6.1.2.1.1.5.0"
OID_SYSLOCATION="1.3.6.1.2.1.1.6.0"

for entrada in "${EQUIPOS[@]}"; do
  nombre="${entrada%%:*}"
  ip="${entrada##*:}"

  echo "=================================================================="
  echo " ${nombre} (${ip})"
  echo "=================================================================="

  echo "--- 1) Lectura con ${COMUNIDAD} (debe funcionar)"
  snmpget -v2c -c "${COMUNIDAD}" "${ip}" "${OID_SYSNAME}"

  echo "--- 2) Escritura con ${COMUNIDAD} (debe fallar: noAccess)"
  snmpset -v2c -c "${COMUNIDAD}" "${ip}" "${OID_SYSLOCATION}" s 'prueba'

  echo "--- 3) sysLocation tras el intento (debe seguir igual)"
  snmpget -v2c -c "${COMUNIDAD}" "${ip}" "${OID_SYSLOCATION}"

  echo "--- 4) Lectura con comunidad incorrecta (debe fallar: timeout)"
  snmpget -v2c -t 2 -r 1 -c "${COMUNIDAD_INVALIDA}" "${ip}" "${OID_SYSNAME}"

  echo
done
