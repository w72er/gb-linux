# Урок 4. Домашнее задание.

1. Потоки ввода/вывода. Создать файл, используя команду echo.
Используя команду cat, прочитать содержимое каталога etc,
ошибки перенаправить в отдельный файл.

```text
echo 'no honey no money' > /tmp/proverb.txt
cat /etc/* 2> /tmp/cat_etc_errors.log
```

2. Конвейер (pipeline). Использовать команду cut на вывод длинного
списка каталога, чтобы отобразить только права доступа к файлам.
Затем отправить в конвейере этот вывод на sort и uniq, чтобы
отфильтровать все повторяющиеся строки.

```text
a@gb-udt:~$ ls -l | tail -n +2 | cut -d ' ' -f 1 | sort | uniq
# `tail -n +2` не выводит первую строку `total 40`
```

3. Управление процессами. Изменить конфигурационный файл службы
`SSH: /etc/ssh/sshd_config`, отключив аутентификацию по паролю
`PasswordAuthentication no`. Выполните рестарт службы
`systemctl restart sshd` `(service sshd restart)`, верните
аутентификацию по паролю, выполните `reload` службы
`systemctl reload sshd` `(services sshd reload)`. В чём различие
между действиями `restart` и `reload`? Создайте файл при помощи
команды `cat > file_name`, напишите текст и завершите комбинацией
`ctrl+d`. Какой сигнал передадим процессу?

Кратко:

* При `restart` перезапускается сервис (меняется его PID).
* Команда `restart` состоит из двух `stop` и `start`, в то время как `reload`
самостоятельная. Для `reload` сервис обрабатывает сигнал `SIGHUP`, а для
`stop`, предположу что `SIGTERM`.
* При команде `restart` логи начинаются с момента запуска сервиса.
* Почему-то не рвется сессия подключенного на localhost пользователя,
  что при `reload`, что при `restart`.

Из интернета:
Ctrl D tells the terminal that it should register a EOF on standard input,
which bash interprets as a desire to exit. Ctrl + D ( ^D ) means end of file.
It only works at the beginning of a line (I'm simplifying a little), and has
no effect if the program isn't reading input from the terminal.
Скорее всего это вообще не сигнал процессу, а просто сигнал о том что файл
stdin прочитан.

Подробно:

```text
a@md:~$ sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
a@md:~$ sudo nano /etc/ssh/sshd_config
a@md:~$ ps -ef | grep sshd
root     2202946       1  0 июн09 ?     00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
a        3303793 3300831  0 10:58 pts/3    00:00:00 grep --color=auto sshd
a@md:~$ sudo systemctl restart sshd
a@md:~$ ps -ef | grep sshd
root     3304566       1  0 10:59 ?        00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
a        3304817 3300831  0 10:59 pts/3    00:00:00 grep --color=auto sshd
a@md:~$ sudo systemctl status sshd
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2021-06-10 10:59:05 +07; 53s ago
       Docs: man:sshd(8)
             man:sshd_config(5)
    Process: 3304565 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 3304566 (sshd)
      Tasks: 1 (limit: 18993)
     Memory: 1.7M
     CGroup: /system.slice/ssh.service
             └─3304566 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups

июн 10 10:59:05 md systemd[1]: Starting OpenBSD Secure Shell server...
июн 10 10:59:05 md sshd[3304566]: Server listening on 0.0.0.0 port 22.
июн 10 10:59:05 md sshd[3304566]: Server listening on :: port 22.
июн 10 10:59:05 md systemd[1]: Started OpenBSD Secure Shell server.

# restart: sshd PID=2202946->3304566

 
a@md:~$ diff -u /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
--- /etc/ssh/sshd_config.bak	2021-06-10 10:56:49.948601367 +0700
+++ /etc/ssh/sshd_config	2021-06-10 10:57:47.179593009 +0700
@@ -56,6 +56,7 @@
 
 # To disable tunneled clear text passwords, change to no here!
 #PasswordAuthentication yes
+PasswordAuthentication no
 #PermitEmptyPasswords no
 
 # Change to yes to enable challenge-response passwords (beware issues with
a@md:~$ sudo mv /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
a@md:~$ nano /etc/ssh/sshd_config # убедился что восстановил файл
a@md:~$ sudo systemctl reload sshd
a@md:~$ ps -ef | grep sshd
root     3304566       1  0 10:59 ?        00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
a        3307611 3300831  0 11:02 pts/3    00:00:00 grep --color=auto sshd
a@md:~$ sudo systemctl status sshd
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2021-06-10 10:59:05 +07; 3min 49s ago
       Docs: man:sshd(8)
             man:sshd_config(5)
    Process: 3304565 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
    Process: 3307562 ExecReload=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
    Process: 3307563 ExecReload=/bin/kill -HUP $MAINPID (code=exited, status=0/SUCCESS)
   Main PID: 3304566 (sshd)
      Tasks: 1 (limit: 18993)
     Memory: 2.1M
     CGroup: /system.slice/ssh.service
             └─3304566 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups

июн 10 10:59:05 md systemd[1]: Starting OpenBSD Secure Shell server...
июн 10 10:59:05 md sshd[3304566]: Server listening on 0.0.0.0 port 22.
июн 10 10:59:05 md sshd[3304566]: Server listening on :: port 22.
июн 10 10:59:05 md systemd[1]: Started OpenBSD Secure Shell server.
июн 10 11:02:38 md systemd[1]: Reloading OpenBSD Secure Shell server.
июн 10 11:02:38 md sshd[3304566]: Received SIGHUP; restarting.
июн 10 11:02:38 md systemd[1]: Reloaded OpenBSD Secure Shell server.
июн 10 11:02:38 md sshd[3304566]: Server listening on 0.0.0.0 port 22.
июн 10 11:02:38 md sshd[3304566]: Server listening on :: port 22.

# reload: sshd PID=3304566->3304566 (не поменялся, значит сервис не перезапускался)
# сервис принял другой сигнал SIGHUP
# Утилитой или функцией kill, с консоли или из скрипта/утилиты для управления
# демоном — для выполнения предусмотренного действия (обычно перечитывания
# конфигурации и переинициализации).


a@md:~$ sudo systemctl restart sshd
a@md:~$ sudo systemctl status sshd
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2021-06-10 11:15:33 +07; 3s ago
       Docs: man:sshd(8)
             man:sshd_config(5)
    Process: 3317363 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 3317364 (sshd)
      Tasks: 1 (limit: 18993)
     Memory: 1.2M
     CGroup: /system.slice/ssh.service
             └─3317364 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups

июн 10 11:15:33 md systemd[1]: Starting OpenBSD Secure Shell server...
июн 10 11:15:33 md sshd[3317364]: Server listening on 0.0.0.0 port 22.
июн 10 11:15:33 md sshd[3317364]: Server listening on :: port 22.
июн 10 11:15:33 md systemd[1]: Started OpenBSD Secure Shell server.

# при перезагрузке сервиса логи начинаются со времени начала загрузки

# почему-то сессия не рвется при restart сервиса. Может потому что подключаюсь
# внутри одного хоста, а `ssh` умный и не использует `socket` который должен
# закрываться?
ssh tuser@localhost
ssh tuser@10.25.64.13

a@md:~$ less /var/log/syslog
Jun 10 10:59:05 md systemd[1]: Stopping OpenBSD Secure Shell server...
Jun 10 10:59:05 md systemd[1]: ssh.service: Succeeded.
Jun 10 10:59:05 md systemd[1]: Stopped OpenBSD Secure Shell server.
Jun 10 10:59:05 md systemd[1]: Starting OpenBSD Secure Shell server...
Jun 10 10:59:05 md systemd[1]: Started OpenBSD Secure Shell server.
Jun 10 10:59:05 md systemd[2950]: run-docker-runtime\x2drunc-moby-1571675fd9e996ec2275cd7d3a595ba2c53e331
d8606115ae18fedd059747d16-runc.Z1GWSA.mount: Succeeded.
Jun 10 10:59:05 md systemd[1]: run-docker-runtime\x2drunc-moby-1571675fd9e996ec2275cd7d3a595ba2c53e331d86
06115ae18fedd059747d16-runc.Z1GWSA.mount: Succeeded.

Jun 10 11:02:38 md systemd[1]: Reloading OpenBSD Secure Shell server.
Jun 10 11:02:38 md systemd[1]: Reloaded OpenBSD Secure Shell server.

# restart это stop + start
# reload это reload
```

4. Сигналы процессам. Запустите mc. Используя ps, найдите PID
процесса, завершите процесс, передав ему сигнал 9.
Подсказка: Запустить оставьте -15 сигнал. Оба варианта будут приняты.

```text
a@gb-udt:~$ mc # в mc нажимаю ctrl+o

a@gb-udt:~$ ps -ef | grep mc
a          19515   19068  0 23:05 pts/0    00:00:00 mc
a          19524   19517  0 23:06 pts/1    00:00:00 grep --color=auto mc
a@gb-udt:~$ kill -15 19515Terminated
```


