SCANNING com NMAP

FLAGS TCP

- SYN - synchronize
- ACK - acknowledgement
- SYN-ACK
- FIN - finalize
- RST - RESET


tipos de port scan com nmap (tcp connect e half open scan)

- nmap -sT -p 80 -Pn 192.168.1 > sT usa tcp connect, realiza todo o threway handshake e pode ser descoberto facilmente por IPSs e IDSs (envia 6 pacotes SYN recebe SYN/ACK, ACK, RST/ACK e RST

- nmap -sS -p 80 -Pn 192.168.1 > sS usa half open scan, realiza apenas o inicio de um threway handshake, e é mais difícil de ser descoberto, pois assim que descobre se o destino está vivo ou aberto, finaliza a conexão (envia apenas 3 pacotes, SYN, recebe SYN/ACK e logo envia um RST para finalixar a conexão.


## nmap

opções default, que precisamos conhecer

```
-sn - detecção de hosts vivos
-sT - TCP connect
-sS - SYN scan / TCP half open
-sV - descobre versões de serviços
-sU - UDP scan
-Pn - ignora a descoberta de host vivo (quando vc já sabe que o host está vivo)
-O - faz detecção de sistema operacional
-A - descobre detalhes sobre o SO e serviços
-p - faz scan completo, varre as 65535 portas
```

# opções avançadas

```
-sF - FIN scan (envia a flag FIN)
-sN - NULL scan (não envia nenhuma flag)
-sX - XMAS scan (envia flags FIN+PSH+URG)
-f - fragmenta os pacotes
-p - define a porta de destino ou range (ex: 80-89)
--open - só mostra portas abertas
-oN - salva em arquivo no formato normal
-oX - salva em arquivo no formato XML
-oG - salva em arquivo no formato para utilizar com grep
```

# nível de agressividade

- -T0 - usado para previinir IDS
- -T1 - espera cerca de 15s durance o scan
- -T2 - espera cerca de 4s duranca o scan
- -T3 - scan normal
- -T4 - scan rápido
- -T5 - scan rápido (porém barulhendo, facilmente detectável por qlqr IDS e IPS)

=================================================================================================


# Consumo de rede em PORT SCAN

(utilizando iptables para pegar esses resultados (iptables -Z para limpar dados de pacotes)


scan com sT (tcp connect) envia 4 pacotes IN e 4 pacotes OUT e tem o tamanho de 224 bytes

scan com sG (halp open scan) envia 3 pacotes IN e 3 pacotes OUT e tem o tamanho de 128 byes


=================================================================================================

## UDP scan

ambiguidade em relação aos resultados, ele não consegue te dizer se está aberta ou filtras e vice versa

opção a ser usada é:

```
nmap -v -sUV -p 53 -Pn 192.168.01 - Assim ele trás informações sobre a versão do serviço se ele conseguir descobrir
```

=================================================================================================

## Network Sweeping

```
nmap -v sn 192.168.0.0/24 -oG hosts.txt

nmap -v -sS --open -p 80 -Pn -iL ips.txt -oG web.txt
```

dica: -p http* (encontra todos os serviços web no range determinado)

dica: -p --top-ports=5 (encontra as 5 principais portas varridas)


=================================================================================================

# Descobrindo Serviços via nmap

```
nmap -v -sV -Pn 192.168.0.1 (vai pesquisar pelas primeiras mil portas)

nmap -v -A -Pn 192.168.0.1 (vai pesquisar pela versão do S.O) ex de retorno do comando: Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel:2.6.18
```

=================================================================================================

# Banner Grabbing (pegar o tipo de serviço e versão que está rodando)

ex:
```
nc -v 192.168.0.1 80
```
ex:

```
nc -v localhost 22
Connection to localhost 22 port [tcp/ssh] succeeded!
SSH-2.0-OpenSSH_7.6p1 Ubuntu-4ubuntu0.3 <<<< banner do ssh mostrando a versão que está rodando
```

================================================================================================

# Port Scan Utilizando o NETCAT

ex:
```
nc -vn -z -w2 192.168.0.1 1-1024  
```
-z para indica um scan
-w timeout ex -w2 (2 segundos)

para udp

ex:
```
nc -vnu -z -w2 192.168.0.1 1-1024  
```

================================================================================================

# Detectando o Sistema Operacional (OS Fingerprint)

pode ser usado o nmap -O (se baseia em implementações da pilha TCP, de acordo com a RFC, ex tempo default de ttl)

ex:
```
nmap -v -O localhost
```
ex de saída:

Device type: general purpose
Running: Linux 2.6.X
OS CPE: cpe:/o:linux:linux_kernel:2.6.32
OS details: Linux 2.6.32

trick:
editar o arquivo de ttl default para burlar o resultado

sudo vim /proc/sys/net/ipv4/ip_default_ttl
editar de 64 para 128 por exemplo

ex host windows

```
nmap -v -O 192.168.0.5 (host windows)
```

ex de saída:
Running: Microsoft Windows 2008|10|7|8.1, Microsoft embedded

================================================================================================

# Fingerprint com XPROBE2

ex:
```
xprobe2 -p tcp:445:open 192.168.0.5 (host windows)
```
ex de saída:

[+] SMB [Native OS: Windows 7 Ultimate 7601 Service Pack 1] [Native Lanman: Windows 7 Ultimate 6.1] [Domain: WORKGROUP]


================================================================================================

# Varredura para by-pass de firewall

ex:
```
nmap -v -sS --source-port 53 192.168.0.1 (by-pass usando portas liberadas)
```

ex:

```
nc -p53 -vn 192.168.0.1 8180 (by-pass usando portas liberadas)
```

ex para pegar o que roda em um server web remoto
```
nc -p53 -vn 192.168.0.1 8180 > /var/www/html/index2.html (dirótio local do apache)
GET / HTTP/1.0
```
