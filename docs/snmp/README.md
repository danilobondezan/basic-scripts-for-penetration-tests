NMAP para escanear SNMP

scan por hosts
ex:
nmap -v --open -sUV -p161 -Pn 192.168.0.0/24


================================================

Usando onesixtyone para procurar por communities

ex:
onesixtyone -c communities.txt -i ips


================================================

Usando snmpwalk para traze informações sobre a community

ex:
snmpwalk -c public -v1 192.168.0.6

Buscar por usuários
ex:
snmpwalk -c public -v1 192.168.0.6 1.3.6.1.4.1.77.1.2.25 (MIB para usuários)

Buscar por portas TCP
ex:
snmpwalk -c public -v1 192.168.0.6 1.3.6.1.2.1.6.12.1.2 (MIB para TCP Ports)

Buscar por programas instalados
ex:
snmpwalk -c public -v1 192.168.0.6 1.3.6.1.2.1.25..6.3.1.2 (MIB para programas instalados)


================================================

Usando snmp-check

ex:
snmp-check -t 192.168.0.6
