1. Подключить репозиторий с nginx любым удобным способом,
установить nginx и потом удалить nginx, используя утилиту dpkg.

## Официальная установка

По ссылке https://nginx.org/ru/linux_packages.html приведена официальная
установка в которой можно взять ссылки на ключ и ресурс.

Кроме того официальная документация показывает, что ключ можно так
же проверить:

Теперь нужно импортировать официальный ключ, используемый apt для проверки подлинности пакетов. Скачайте ключ:
```shell
curl -o /tmp/nginx_signing.key https://nginx.org/keys/nginx_signing.key
```

Проверьте, верный ли ключ был загружен:
```shell
gpg --dry-run --quiet --import --import-options import-show /tmp/nginx_signing.key
```

Вывод команды должен содержать полный отпечаток ключа 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62:
```
pub   rsa2048 2011-08-19 [SC] [expires: 2024-06-14]
uid   [ unknown] nginx signing key <signing-key@nginx.com>
      573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
uid
                      nginx signing key <signing-key@nginx.com>
```

Переместите ключ в каталог доверенных ключей apt (обратите внимание на изменение расширения "asc"):
```shell
sudo mv /tmp/nginx_signing.key /etc/apt/trusted.gpg.d/nginx_signing.asc
```

А еще указывают на проблему которой не существует:

Для использования пакетов из нашего репозитория вместо распространяемых в дистрибутиве, настройте закрепление:
```shell
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | sudo tee /etc/apt/preferences.d/99nginx
```

## Моя установка

Конечно, я мог бы просто повторить команды с официальной документации,
но мне захотелось повторить озвученные в уроке шаги:
* найти репозиторий и ключ (в официальной документации)
* добавить репозиторий и ключ в `Ubuntu`
* установить `nginx`

Проблемы:
* https://www.lightnetics.com/topic/16739/n-skipping-acquire-of-configured-file-nginx-binary-i386-packages-as-repository-http-nginx-org-packages-ubuntu-bionic-inrelease
* установленный из nginx.org nginx не поднялся.

```shell
a@gb-udt:~$ echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
deb http://nginx.org/packages/ubuntu focal nginx
a@gb-udt:~$ curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
OK
a@gb-udt:~$ sudo apt update
Hit:1 http://ru.archive.ubuntu.com/ubuntu focal InRelease
Get:34 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 DEP-11 Metadata [2 468 B]
Fetched 7 067 kB in 3s (2 153 kB/s)                                       
Reading package lists... Done
Building dependency tree       
Reading state information... Done
39 packages can be upgraded. Run 'apt list --upgradable' to see them.
N: Skipping acquire of configured file 'nginx/binary-i386/Packages' as repository 'http://nginx.org/packages/ubuntu focal InRelease' doesn\'t support architecture 'i386'

a@gb-udt:~$ echo "deb [arch=amd64] http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
deb [arch=amd64] http://nginx.org/packages/ubuntu focal nginx
a@gb-udt:~$ cat /etc/apt/sources.list.d/nginx.list
deb [arch=amd64] http://nginx.org/packages/ubuntu focal nginx

a@gb-udt:~$ sudo apt update 
Hit:1 http://ru.archive.ubuntu.com/ubuntu focal InRelease
Hit:2 http://ru.archive.ubuntu.com/ubuntu focal-updates InRelease              
Hit:3 http://ru.archive.ubuntu.com/ubuntu focal-backports InRelease                            
Hit:4 http://nginx.org/packages/ubuntu focal InRelease                                         
Get:5 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Fetched 114 kB in 1s (89,0 kB/s)   
Reading package lists... Done
Building dependency tree       
Reading state information... Done
39 packages can be upgraded. Run 'apt list --upgradable' to see them.

a@gb-udt:~$ sudo apt-get install nginx
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  nginx
0 upgraded, 1 newly installed, 0 to remove and 39 not upgraded.
Need to get 878 kB of archives.
After this operation, 3 116 kB of additional disk space will be used.
Get:1 http://nginx.org/packages/ubuntu focal/nginx amd64 nginx amd64 1.20.1-1~focal [878 kB]
Fetched 878 kB in 1s (1 187 kB/s)
Selecting previously unselected package nginx.
(Reading database ... 168105 files and directories currently installed.)
Preparing to unpack .../nginx_1.20.1-1~focal_amd64.deb ...
----------------------------------------------------------------------

Thanks for using nginx!

Please find the official documentation for nginx here:
* https://nginx.org/en/docs/

Please subscribe to nginx-announce mailing list to get
the most important news about nginx:
* https://nginx.org/en/support.html

Commercial subscriptions for nginx are available on:
* https://nginx.com/products/

----------------------------------------------------------------------
Unpacking nginx (1.20.1-1~focal) ...
Setting up nginx (1.20.1-1~focal) ...
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /lib/systemd/system/nginx.service.
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for systemd (245.4-4ubuntu3.6) ...
a@gb-udt:~$ sudo systemctl status nginx
● nginx.service - nginx - high performance web server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
     Active: inactive (dead)
       Docs: https://nginx.org/en/docs/
a@gb-udt:~$ dpkg --list | grep nginx
ii  nginx                                      1.20.1-1~focal                      amd64        high performance web server
a@gb-udt:~$ sudo dpkg --purge nginx
(Reading database ... 168139 files and directories currently installed.)
Removing nginx (1.20.1-1~focal) ...
Purging configuration files for nginx (1.20.1-1~focal) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for systemd (245.4-4ubuntu3.6) ...
a@gb-udt:~$ dpkg --list | grep nginx
```