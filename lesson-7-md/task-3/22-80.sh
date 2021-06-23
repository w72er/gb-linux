
iptables -F # очистка всех имеющихся правил

# Действия по умолчанию, что будет с пакетом если он не попадает
# ни под одно правилу, описанному ниже.
# Мы видим, что пакеты удаляются. И это правильный подход к построению фильтра
# (безопасности): сначала все запрещаем, а затем разрешаем что нужно.
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Разрешаем обмен по локальной петле/ Разрешают взаимодействие
# по протоколу TCP/IP. Процессы могут взаимодействовать между собой

# -A добавить правило для цепочки инпут для интерфейса локалхост
# действие разрешено
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Разрешаем пакеты icmp (для обмена служебной информацией)
# Если мы не сможем пропускать эти пакеты, то протокол
# TCP/IP работать не будет.
iptables -A INPUT -p icmp -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT

# Разрешаем соединения с динамических портов
# ssh 22, http 80, но бывают системы которые отвечают отправляют
# свои ответы из специального диапазона динамических портов.
# Обратите внимание, что из этих портов только исходящий трафик.
iptables -A OUTPUT -p TCP -m tcp --sport 32768:61000 -j ACCEPT
iptables -A OUTPUT -p UDP -m udp --sport 32768:61000 -j ACCEPT

# Разрешить только те пакеты, которые мы запросили.
# Разрешаем все пакеты протоколов TCP, UDP,
# То есть пропускаем все пакеты, которые относятся к действующему соединению.
# То есть установить соединение с имеющейся системой нельзя, а вот передавать
# данные по имеющимся соединениям можно.
iptables -A INPUT -p TCP -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p UDP -m state --state ESTABLISHED,RELATED -j ACCEPT


# Но если работаем как сервер SSH, следует разрешит и нужные порты
# Разрешаем проход пакетов с порта 22 и на порт 22
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --sport 22 -j ACCEPT

iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --sport 80 -j ACCEPT

