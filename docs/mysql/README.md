NMAP para escanear MYSQL

scan por hosts na rede
ex:
nmap -v --open -sS -p3306 -Pn 192.168.0.0/24


============================================================

Tentando conexão

apt install mysql-client

mysql -h 192.168.0.6 -u root
