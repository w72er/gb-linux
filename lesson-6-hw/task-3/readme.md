Использовать команду `AWK` на вывод длинного списка каталога, чтобы
отобразить только права доступа к файлам. Затем отправить в конвейере
этот вывод на `sort` и `uniq`, чтобы отфильтровать все повторяющиеся
строки.

Возьмем ответ из задачи 2 урока 4:
```text
a@gb-udt:~$ ls -l | tail -n +2 | cut -d ' ' -f 1 | sort | uniq
# `tail -n +2` не выводит первую строку `total 40`
```

Заменим `cut -d ' ' -f 1` на `awk '{ print $1 }'`
```text
a@md:/$ ls -l | tail -n +2 | awk '{ print $1 }' | sort | uniq
drwx------
drwxrwxrwt
drwxrwxr-x
drwxr-xr-x
dr-xr-xr-x
lrwxrwxrwx
-rw-------
```
