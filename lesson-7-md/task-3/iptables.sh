#!/usr/bin/env bash

iptables -F

# drop the traffic from only explored chain that support filter.
iptables -P INPUT DROP # 1
#iptables -P FORWARD DROP
#iptables -P OUTPUT DROP

# then add the rules that makes what you want
#iptables -A INPUT -i lo -j ACCEPT # makes `ssh a@localhost` worked
iptables -A INPUT -p tcp --dport 22 -j ACCEPT # makes `ssh a@192.168.1.56` worked


