#!/bin/bash

if [ "$1" == "" ]
then 
echo "curso de pentest"
echo "exemplo de uso 192.168.0"
else
for host in $(seq 1 254); do
ping -c1 $1.$host | grep "64 bytes" | cut -d " " -f 4  
done
fi
