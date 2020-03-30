#!/bin/bash

#set -x
#Diretorio

for palavra in $(cat lista.txt)
do
resposta=$(curl -s -o /dev/null -w "%{http_code}" $1/$palavra/)
if [[ $resposta == "200" ]] || [[ $reposta == "301" ]];
then
echo "Diretorio Encontrado: $palavra"
fi
done

#Arquivos
for palavra in $(cat lista.txt)
do
resposta=$(curl -s -o /dev/null -w "%{http_code}" $1/$palavra)
if [[ $resposta == "200" ]] || [[ $reposta == "301" ]];
then
echo "Arquivo Encontrado: $palavra"
fi
done
