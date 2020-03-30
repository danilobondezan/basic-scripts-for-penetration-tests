# import requests
# r = requests.get('https://google.com.br')
# r.status_code
#
# print r


# import keyword
#
# print keyword.kwlist * 100


# ip = raw_input('Digite um endereco IP: ')
#
# print 'O endereco %s e privado' % ip
# print 'O endereco %s e privado e tem %d caracteres' %(ip,len(ip))

# contador = 0
# while contador <= 1024:
#     print contador
#     contador = contador + 1
#     if 'error '

# for x in range(255,-1,-1):
#     ip = '192.168.0.%s' % x
#     print ip
#     if ip == '192.168.0.128':
#         break

# ports = [80, 443, 22]
# for y in range(10,15):
#     for x in ports:
#         print 'Scan sendo realizado no ip 192.168.0.%s na porta %d' %(y,x)
#     print

var = list()
while True:
    msg = raw_input('Digite um numero ou nada para sair: ')
    if msg:
        var.append(msg)
    else:
        break
print var
