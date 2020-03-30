#!/bin/bash

echo "Buscando Registros"
for url in $(cat lista-dns.txt)
do
host $url.$1 | grep -v "not found" | cut -d " " -f4 >> hosts.txt
done
cat hosts.txt

echo "Pesquisando Reverso"
# Reverso
for ip in $(cat hosts.txt)
do host $ip
done
rm hosts.txt
