# Пользователи и управление пользователями

План урока:
* Типы пользователей.
* Управление пользователями и группами.
* Утилиты sudo, su.

## Типы пользователей

Пользователь - ключевое понятие для организации доступа. Содержит 2 атрибута:
UID - отличие одного пользователя от другого врутри одной системы.
GID - идентификатор основной группы пользователя. При создании пользователя создается одноименная группа, и пользователь получает ее как основную.

Три группы пользователей:
* суперпользователь (root) - имеет доступ ко всему в системе.
* демоны (псевдопользователи, пользователи служб) - учетные записи используются процессами. Для того что бы демонам можно запускаться, взаимодействовать с другими пользователями. Не могут входить в оболочку.
* Пользователи - учетные записи создаются для людей. Такой пользователь получает оболочку, чтобы работать с системой.

Когда задача требует получения информации с нескольких серверов, для подключения к нескольким серверам нужна учетная запись, даже для скрипта.

Система понимает, что пользователь - суперпользователь, по нулевым UID, GID.
Все изменения в системе выполняются под учетной записью суперпользователя:
* Изменение конфигурации
* Запуск системных служб
* Подключение устройств

sshd - такие службы запускаются под учетками одноименных пользователей. Сначала такие службы запускались от рута, но это не безопасно, так как имеют доступ рута.

Обычные пользователи создаются суперадминистратором.
* ldap - пользователь может создаваться на уровне сети.
* локально на компьютере

Видеть информацию о пользователях и группах:
/etc/passwd - список учеток всех пользователей до текущего момента
/etc/group - о всех группах, и пользователях входящих в эти группы
/etc/shadow - пароли.

### /etc/passwd

Изначально пароли хранились в /etc/password/ и был доступен всем пользователям, и можно было перебирать хэши, так что пароли перенесены в другой файл, и доступен для чтения не всем.

```text
a@gb-udt:~$ cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
```

username:password:uid:gid:comment:home-directory:
* где находится папка запускаемого демона.

* system users nologin or /bin/false
* /bin/bash root or common user

* system uid [0: 1000)
* обычные пользователи [1000, +)

### /etc/group

```text
a@gb-udt:~$ cat /etc/group
root:x:0:
daemon:x:1:
adm:x:4:syslog,a
tty:x:5:syslog
```

group_name:password-for-group:group_id:users-in-group

password-for-group используется на практике редко.

### /etc/shadow

```text

a@gb-udt:~$ sudo cat /etc/shadow
[sudo] password for a:
root:!:18777:0:99999:7:::
daemon:*:18667:0:99999:7:::
bin:*:18667:0:99999:7:::
sys:*:18667:0:99999:7:::
a:$6$3sbjTzQbTucj1Ugx$NeuUCKBvg7S9PRMqQ6jzBJRI8vRRQtY1sVzDOHnf0z3419Y3Zdviwo0lFI2jHe9xKCpcNZGoGoUbDTJOcfSSm0:18777:0:99999:7:::
```

У root нет пароля об этом говорит "!", значит мы не можем под этим пользователем залогиниться. Очень легко перепутать на каком сервере выполнять команду, поэтому входим не под системным администратором.
У псевдопользователей (службы) нет пароля, то есть "*".
name:password:специальные_настройки

Если допустить ошибку в файлах, то никто-не сможет залогиниться, поэтому применяются для редактирования утилиты.

```text
a@gb-udt:~$ id
uid=1000(a) gid=1000(a) groups=1000(a),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),120(lpadmin),131(lxd),132(sambashare)
```

Процессы не общаются через интерактивную оболочку. Интерактивное взаимодействие с операционной системой - `bash`.
Псевдопользователи не могут войти, т.к. если бы могли, то через них можно войти, используя пароль, что повышает риск в безопасности.


## Управление пользователями и группами.

### Добавить пользователя

```text
sudo useradd -m -s /bin/bash user1 
# -m автоматически создать домашнюю папку в /home/
# -s /bin/bash - оболочка пользователя
# user1 - имя пользователя


# пароль у пользователя "!", значит мы не сможем войти под ним, так как не указан пароль.
```

```text
sudo adduser user2

# пароль имеется и он может войти в систему интерактивно.
```

### Создание групп

```text
sudo groupadd team1
# аналогично работает addgroup
sudo addgroup team2
```

### passwd

`passwd username` изменит пароль пользователя.
`passwd` без имени, изменит пароль текущего пользователя.

`usermod` - изменяет атрибуты пользователя.


Если пользователя добавить в группу `sudo`, то пользователь сможет выполнять команду `sudo`.
Добавить пользователя user1 в группу `sudo`

```text
sudo usermode -a
# -a append
# -G добавляем в дополнительную группу

cat /etc/group

sudo:x:27:user,user1
```

## Утилиты sudo, su.

### su
su - команда позволяет в текущей сессией перейти в другого пользователя. Созданно для временного перехода в другого пользователя. Переход осуществляется быстро.

у нашего root нет пароля, то и `su` без имени не сработает.

sudo пароль текущего пользователя.

хотя мы и переключились, мы по прежнему работаем в окружении старого пользователя и старой домашней директории
`su - user1` - c "-" исправит эту ситуации.
`exit` - выход из временной сессии.

### sudo

`sudo` - использует настройки из файла /etc/sudoers, то есть описаны возможности.
```text
sudo cat /etc/sudoers
root ALL=(ALL:ALL) ALL # использовать судо на всех хостах. =( Пользователь рут может вызывать под любыми пользователями. ":" Пользователь рут может выпольнить действие под любой группой.) И может выполнить любую команду.
user1 ALL=adduser # может добавлять пользователя.
%admin ...
%sudo ...
```

`sudo sudoedit`, `sudo visudo`

`sudoedit /etc/sudoers` - проверит корректность новых настроек.

`sudo userdel -r user2` `-r` удалить почту и рабочую группу.

`sudo groupdel team2`

При наборе команд вы могли заметить автодополнение:
* путей
* набора команд

`su` `2*tab` покажутся подсказки.

`history` мы можем ввести команду по ее номеру в `history`, например `!40`
стрелки вверх и вниз ходим по истории.
`^r` - поиск по history как в текстовом файле.

### Владелец и группа владельца

Любой каталог или файл имеет владельца или группу владельца.

`ls -l`
```text
touch file1.txt
теперь нам надо поменять владельца данного пользователя файла
теперь воспользуемся chown
sudo chown user1:team1 file1.txt
так же мы можем поменять только группу
sudo chgrp user1 file1.txt
```

Если хотим изменить рекурсивно, то нужно изменять с помощью ключа.
`-R`:
```text
sudo chown -R user1:user1 lesson3/
```

1. Создать пользователя в ручном режиме, мы можем редактировать пользователя через редактор. Задание c. оставляю на усмотрение.
вместо с помощью скрипта adduser.
2.
b. usermod -g -маленькое
Получайте самостоятельно информацию.
3.
создать обычного пользователя и добавить его в судо
нужное действие есть в методичке.

по пунктам команды текстом.
где команд нет, но нужно показать действие, присылаем скриншот.

## Домашняя работа

```text
ssh a@192.168.1.56
```

1. Управление пользователями:
a. создать пользователя, используя утилиту useradd;
```text
a@gb-udt:~$ sudo useradd tuser1
# tuser1:!:18785:0:99999:7:::
a@gb-udt:~$ su tuser1
Password:
su: Authentication failure
a@gb-udt:~$ sudo passwd tuser1
New password:
Retype new password:
passwd: password updated successfully
# tuser1:$6$YVyHCYs7qxeQgj3e$e/UoPku/0Rr2mJ5mNtEw3K6ng9Y47ktGGPiE.iU71cavWa6aSu0ZWOWPRaAPT8LEDFm.N9et4zGLD/C6cqz/H/:18785:0:99999:7:::
a@gb-udt:~$ su tuser1
Password:
$ ll # /bin/sh
sh: 1: ll: not found
$
```
b. удалить пользователя, используя утилиту userdel;
```text
a@gb-udt:~$ sudo userdel tuser1
```
c. создать пользователя в ручном режиме.
```text
a@gb-udt:~$ sudo adduser tuser2
Adding user `tuser2' ...
Adding new group `tuser2' (1001) ...
Adding new user `tuser2' (1001) with group `tuser2' ...
Creating home directory `/home/tuser2' ...
Copying files from `/etc/skel' ...
New password:
Retype new password:
passwd: password updated successfully
Changing the user information for tuser2
Enter the new value, or press ENTER for the default
        Full Name []:
        Room Number []:
        Work Phone []:
        Home Phone []:
        Other []:
Is the information correct? [Y/n] Y
a@gb-udt:~$ su tuser2
Password:
tuser2@gb-udt:/home/a$ cd ~
tuser2@gb-udt:~$ ll
total 20
drwxr-xr-x 2 tuser2 tuser2 4096 июн  7 23:01 ./
drwxr-xr-x 4 root   root   4096 июн  7 23:01 ../
-rw-r--r-- 1 tuser2 tuser2  220 июн  7 23:01 .bash_logout
-rw-r--r-- 1 tuser2 tuser2 3771 июн  7 23:01 .bashrc
-rw-r--r-- 1 tuser2 tuser2  807 июн  7 23:01 .profile
tuser2@gb-udt:~$ pwd
/home/tuser2
```
2. Управление группами: 
a. создать группу с использованием утилит и в ручном режиме;
   `sudo groupadd tgroup2`
b. попрактиковаться в смене групп у пользователей;
```text
a@gb-udt:~$ sudo usermod -g tgroup2 tuser2
# /tmp/passwd
# tuser2:x:1001:1002:,,,:/home/tuser2:/bin/bash
# /tmp/group
# tuser2:x:1001:
# tgroup2:x:1002:
```
c. добавить пользователя в группу, не меняя основной;
```text
a@gb-udt:~$ sudo usermod -aG tuser2 tuser2
# /etc/group
# tuser2:x:1001:tuser2
# tgroup2:x:1002:
```
d. удалить пользователя из группы.
```text
a@gb-udt:~$ sudo deluser tuser2 tuser2
Removing user `tuser2' from group `tuser2' ...
Done.
# /etc/group
# tuser2:x:1001:a
```

3. Добавить пользователя, имеющего право выполнять команды/действия 
от имени суперпользователя.
Сделать так, чтобы `sudo` не требовал пароль для выполнения команд.
```text
# -G имя дополнительной группы, -a - добавить в дополнительную
# группу, не исключая из основной.
a@gb-udt:~$ sudo usermod -aG sudo tuser1
a@gb-udt:~$ sudo cat /etc/group | grep sudo
sudo:x:27:a,tuser1

a@gb-udt:~$ su - tuser1 
Password: 
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

tuser1@gb-udt:~$ sudo cat /etc/passwd
[sudo] password for tuser1: 
root:x:0:0:root:/root:/bin/bash

tuser1@gb-udt:~$ sudo sudoedit /etc/sudoers
sudo: sudoedit doesn't need to be run via sudo
# пользователей добавляем после sudo% - иначе не работает
# %sudo	ALL=(ALL:ALL) ALL
#
# tuser1  ALL=(ALL) NOPASSWD:ALL
```


4. * Используя дополнительные материалы, выдать одному из созданных 
пользователей право на выполнение ряда команд, требующих прав
суперпользователя (команды выбираем на своё усмотрение). 

```text
a@gb-udt:~$ which adduser
/usr/sbin/adduser
a@gb-udt:~$ sudo adduser odmin
a@gb-udt:~$ sudo visudo /etc/sudoers
a@gb-udt:~$ sudo visudo /etc/sudoers
>>> /etc/sudoers: syntax error near line 34 <<<
What now? 
a@gb-udt:~$ sudo cat /etc/sudoers | grep odmin
odmin   ALL= /bin/systemctl, /usr/sbin/adduser


a@gb-udt:~$ su - odmin 
Password: 
odmin@gb-udt:~$ systemctl status sshd
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: e>
     Active: active (running) since Tue 2021-06-08 20:19:48 +07; 59min ago
       Docs: man:sshd(8)
             man:sshd_config(5)
    Process: 623 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 637 (sshd)
      Tasks: 1 (limit: 2315)
     Memory: 2.4M
     CGroup: /system.slice/ssh.service
             └─637 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups

Warning: some journal files were not opened due to insufficient permissions.
odmin@gb-udt:~$ sudo adduser tuser3
[sudo] password for odmin: 
Adding user `tuser3' ...
Adding new group `tuser3' (1004) ...
Adding new user `tuser3' (1004) with group `tuser3' ...
Creating home directory `/home/tuser3' ...
Copying files from `/etc/skel' ...
New password: 
Retype new password: 
passwd: password updated successfully
Changing the user information for tuser3
Enter the new value, or press ENTER for the default
	Full Name []: 
	Room Number []: 
	Work Phone []: 
	Home Phone []: 
	Other []: 
Is the information correct? [Y/n] 

```