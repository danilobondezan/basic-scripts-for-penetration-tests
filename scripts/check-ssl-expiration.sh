#/bin/bash

DOMAIN=$1
PORT=443

echo | openssl s_client -servername $DOMAIN -connect $DOMAIN:$PORT | openssl x509 -noout -dates
