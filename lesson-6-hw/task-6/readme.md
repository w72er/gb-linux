.* Написать скрипт, делающий архивную копию каталога etc, и прописать
задание в crontab.

Боюсь, что не доберусь до этой задачи, но на всякий 

Решение описано в статье http://heap.altlinux.org/alt-docs/compactbook/backup.alenitchev/index.html
Сложности с правами не должно возникнуть поскольку правится `crontab` `root`а.

Создадим файл `/usr/bin/full-backup` и сделаем его исполняемым.
```shell
#!/bin/sh
tar -zcf /backup/etc.tar.gz /etc
```

Редактируем `/etc/crontab` файл
```text
#мин        час        число        месяц        день недели        команда
0        1        *        *        5                /usr/bin/full-backup
```
