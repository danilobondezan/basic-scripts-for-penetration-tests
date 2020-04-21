=======================================================

Banner Grabbing HTTP

ex HTTP:
nc -v 192.168.0.11 80
Connection to 192.168.0.11 80 port [tcp/http] succeeded!
GET / HTTP/1.0

nc -v 192.168.0.11 80
Connection to 192.168.0.11 80 port [tcp/http] succeeded!
HEAD / HTTP/1.0          

ex SSH:
nc -v 192.168.0.11 22
Connection to 192.168.0.11 22 port [tcp/ssh] succeeded!
SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.8


=======================================================

Banner Grabbing HTTPS

ex:
openssl s_client -quiet -connect www.shopback.com.br:443
HEAD / HTTP/1.0
host:www.shopback.com.br

retorno:
HTTP/1.1 200 OK
Date: Sun, 05 Apr 2020 22:02:10 GMT
Content-Type: text/html
Content-Length: 24907
Connection: close
Server: nginx/1.10.3 (Ubuntu)
Last-Modified: Wed, 04 Mar 2020 19:15:42 GMT
ETag: "5e5ffe5e-614b"
Accept-Ranges: bytes
