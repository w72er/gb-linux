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