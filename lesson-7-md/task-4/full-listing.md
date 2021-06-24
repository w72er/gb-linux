Полный вывод команд, используемых в тестах.

```text
# /etc/apt/sources.list.d/nginx.list
sudo sysctl -w net.ipv4.ip_forward=1

# sudo iptables -t nat -i lo -A PREROUTING -p tcp --dport 81 -j REDIRECT --to-ports 80
# sudo iptables -t nat -A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-ports 80
# sudo iptables -t nat -A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-ports 80

sudo iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 127.0.0.1:80

sudo iptables -p tcp --dport 8080 -j DROP

a@gb-udt:~$ sudo iptables -A INPUT -p tcp --dport 8080 -j DROP # works
a@gb-udt:~$ sudo iptables -A PREROUTING -p tcp --dport 8080 -j DROP  # not works, no filter table

echo "This is my TCP message" > /dev/tcp/127.0.0.1/8080


a@gb-udt:~$ sudo iptables -L -v
Chain INPUT (policy ACCEPT 1 packets, 105 bytes)
 pkts bytes target     prot opt in     out     source               destination
   13   780 DROP       tcp  --  any    any     anywhere             anywhere             tcp dpt:http-alt # echo "This is my TCP message" > /dev/tcp/127.0.0.1/8080
    0     0 DROP       tcp  --  lo     any     anywhere             anywhere             tcp dpt:http-alt
    2   120 DROP       tcp  --  lo     any     anywhere             anywhere             tcp dpt:http # echo "This is my TCP message" > /dev/tcp/127.0.0.1/80


a@gb-udt:~$ sudo iptables -t nat -A OUTPUT -p tcp --dport 8080 -j REDIRECT --to-port 80
a@gb-udt:~$ sudo iptables -t nat -L -v
Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
    0     0 REDIRECT   tcp  --  any    any     anywhere             anywhere             tcp dpt:http-alt redir ports 80

Chain POSTROUTING (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
a@gb-udt:~$ echo "This is my TCP message" > /dev/tcp/127.0.0.1/8080
a@gb-udt:~$ sudo iptables -t nat -L -v
Chain PREROUTING (policy ACCEPT 2 packets, 60 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain INPUT (policy ACCEPT 2 packets, 60 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
    1    60 REDIRECT   tcp  --  any    any     anywhere             anywhere             tcp dpt:http-alt redir ports 80

Chain POSTROUTING (policy ACCEPT 1 packets, 60 bytes)
 pkts bytes target     prot opt in     out     source               destination
a@gb-udt:~$ curl localhost:8080
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
a@gb-udt:~$
```