Чтобы понять правильно ли написано условие, можно удалять пакеты в
тестируемой цепочке, и подбирать условие, которое разрешит их
пропускать. Например, так:
```shell
iptables -P INPUT DROP # 1

# then add the rules that makes what you want
#iptables -A INPUT -i lo -j ACCEPT # makes `ssh a@localhost` worked

# or
iptables -A INPUT -p tcp --dport 22 -j ACCEPT # makes `ssh a@192.168.1.56` worked
```



