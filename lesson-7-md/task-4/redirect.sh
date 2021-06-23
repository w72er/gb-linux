#!/usr/bin/env bash

# /etc/apt/sources.list.d/nginx.list
sudo sysctl -w net.ipv4.ip_forward=1

# sudo iptables -t nat -i lo -A PREROUTING -p tcp --dport 81 -j REDIRECT --to-ports 80
# sudo iptables -t nat -A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-ports 80
# sudo iptables -t nat -A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-ports 80

sudo iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 127.0.0.1:80

