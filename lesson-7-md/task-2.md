_2. Установить пакет на свой выбор, используя snap.

Не всегда хорошо ищутся пакеты, в основном система предлагает устанавливать через `apt`.
Сервер `nginx` не нашел, выбрал первого встречного `gitea`:

```
a@gb-udt:~$ 
a@gb-udt:~$ snap search nginx
Name               Version  Publisher  Notes  Summary
nginxrtmp-minsikl  0.1      minsikl    -      Live Streaming server based on NGINX and RTMP
a@gb-udt:~$ snap find nginx
Name               Version  Publisher  Notes  Summary
nginxrtmp-minsikl  0.1      minsikl    -      Live Streaming server based on NGINX and RTMP
a@gb-udt:~$ git

Command 'git' not found, but can be installed with:

sudo apt install git

a@gb-udt:~$ snap find git
Name                          Version                    Publisher             Notes    Summary
gitkraken                     7.6.1                      gitkraken✓            classic  For repo management, in-app code editing & issue tracking.
gitea                         v1.14.3                    gitea                 -        Gitea - A painless self-hosted Git service
...
space                         2021.1.2                   jetbrains✓            -        Desktop Application for JetBrains Space

a@gb-udt:~$ sudo snap install gitea
gitea v1.14.3 from Gitea installed
a@gb-udt:~$ sudo systemctl status gitea
Unit gitea.service could not be found.
  
a@gb-udt:~$ which gitea
/snap/bin/gitea
a@gb-udt:~$ gitea --help
NAME:
   Gitea - A painless self-hosted Git service
   ...

a@gb-udt:~$ 
```