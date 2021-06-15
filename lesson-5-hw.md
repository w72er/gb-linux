1. Создать файл file1 и наполнить его произвольным содержимым.
Скопировать его в file2. Создать символическую ссылку file3 на file1.
Создать жёсткую ссылку file4 на file1.
Посмотреть, какие inode у файлов.
Удалить file1. Что стало с остальными созданными файлами?
Попробовать вывести их на экран.
   
```text
a@gb-udt:~$ cd /tmp/
a@gb-udt:/tmp$ mkdir hw-5
a@gb-udt:/tmp$ cd hw-5/
a@gb-udt:/tmp/hw-5$ echo 'text' > file1.txt
a@gb-udt:/tmp/hw-5$ cp file1.txt file2.txt
a@gb-udt:/tmp/hw-5$ cat *
text
text
a@gb-udt:/tmp/hw-5$ ln -s file1.txt file3.txt
a@gb-udt:/tmp/hw-5$ ln file1.txt file4.txt
a@gb-udt:/tmp/hw-5$ ls -il
total 12
264898 -rw-rw-r-- 2 a a 5 июн 14 18:15 file1.txt
264899 -rw-rw-r-- 1 a a 5 июн 14 18:15 file2.txt
264900 lrwxrwxrwx 1 a a 9 июн 14 18:16 file3.txt -> file1.txt
264898 -rw-rw-r-- 2 a a 5 июн 14 18:15 file4.txt
# Видим что у file1.txt и file4.txt есть общий inode.  

a@gb-udt:/tmp/hw-5$ rm file1.txt 
a@gb-udt:/tmp/hw-5$ ls -il
total 8
264899 -rw-rw-r-- 1 a a 5 июн 14 18:15 file2.txt
264900 lrwxrwxrwx 1 a a 9 июн 14 18:16 file3.txt -> file1.txt
264898 -rw-rw-r-- 1 a a 5 июн 14 18:15 file4.txt
a@gb-udt:/tmp/hw-5$ cat file2.txt 
text
a@gb-udt:/tmp/hw-5$ cat file3.txt 
cat: file3.txt: No such file or directory
a@gb-udt:/tmp/hw-5$ cat file4.txt 
text
a@gb-udt:/tmp/hw-5$ 
# При удалении file1 его содержимое осталось доступно в file4.txt, поскольку
# это жесткая ссылка, которая имела тот inode, в котором было содержимое
# file1.txt.
# А вот содержимое файла символической ссылки не удалось получить,
# поскольку имя в директории на которое оно ссылалось удалено.
```

2. Дать созданным файлам другие, произвольные имена. Создать новую
символическую ссылку. Переместить ссылки в другую директорию.

```text
a@gb-udt:/tmp/hw-5$ echo 'file.txt' > file.txt
a@gb-udt:/tmp/hw-5$ ln -s /tmp/hw-5/file.txt abs-ln-to-file.txt
a@gb-udt:/tmp/hw-5$ ln -s file.txt rel-ln-to-file.txt
a@gb-udt:/tmp/hw-5$ ln file.txt hard-ln-to-file.txt
a@gb-udt:/tmp/hw-5$ mkdir other
a@gb-udt:/tmp/hw-5$ mv rel-ln-to-file.txt other/
a@gb-udt:/tmp/hw-5$ mv abs-ln-to-file.txt other/
a@gb-udt:/tmp/hw-5$ mv hard-ln-to-file.txt other/

 
a@gb-udt:/tmp/hw-5$ cat file.txt 
file.txt
a@gb-udt:/tmp/hw-5$ ls other/
abs-ln-to-file.txt  hard-ln-to-file.txt  rel-ln-to-file.txt
a@gb-udt:/tmp/hw-5$ cat other/abs-ln-to-file.txt 
file.txt
a@gb-udt:/tmp/hw-5$ cat other/hard-ln-to-file.txt 
file.txt
a@gb-udt:/tmp/hw-5$ cat other/rel-ln-to-file.txt 
cat: other/rel-ln-to-file.txt: No such file or directory

# Жесткие ссылки и символические ссылки с абсолютным путем
# можно переносить без потери работоспособности.

a@gb-udt:/tmp/hw-5$ cd other
a@gb-udt:/tmp/hw-5/other$ ln -s ../file-not-found.txt rel-not-found
a@gb-udt:/tmp/hw-5/other$ ll
total 12
drwxrwxr-x 2 a a 4096 июн 14 22:04 ./
drwxrwxr-x 3 a a 4096 июн 14 21:59 ../
lrwxrwxrwx 1 a a   18 июн 14 21:57 abs-ln-to-file.txt -> /tmp/hw-5/file.txt
-rw-rw-r-- 2 a a    9 июн 14 21:56 hard-ln-to-file.txt
lrwxrwxrwx 1 a a    8 июн 14 21:57 rel-ln-to-file.txt -> file.txt
lrwxrwxrwx 1 a a   21 июн 14 22:04 rel-not-found -> ../file-not-found.txt
a@gb-udt:/tmp/hw-5/other$ ln ../file-not-found.txt hard-not-found
ln: failed to access '../file-not-found.txt': No such file or directory
# Символическую ссылку можно создать на несуществующий файл,
# а жесткую - нельзя
```

3. Создать два произвольных файла. Первому присвоить права на чтение
и запись для владельца и группы, только на чтение — для всех.
Второму присвоить права на чтение и запись только для владельца.
Сделать это в численном и символьном виде.

```text
a@gb-udt:/tmp/hw-5$ touch 1.txt
a@gb-udt:/tmp/hw-5$ touch 2.txt
# 1.txt rw- rw- r--
# 2.txt rw- --- ---
# 
# rw- 110 6
# --- 000 0
# 
# по умолчанию файлы создаются с правами -rw-rw-r--
a@gb-udt:/tmp/hw-5$ chmod ugo=r 1.txt
a@gb-udt:/tmp/hw-5$ chmod ug+w 1.txt
a@gb-udt:/tmp/hw-5$ chmod 600 2.txt 
a@gb-udt:/tmp/hw-5$ ls -l
total 0
-rw-rw-r-- 1 a a 0 июн 14 22:18 1.txt
-rw------- 1 a a 0 июн 14 22:18 2.txt
```

4. * Создать группу developer и нескольких пользователей, входящих в
неё. Создать директорию для совместной работы. Сделать так, чтобы
созданные одними пользователями файлы могли изменять другие
пользователи этой группы.

Решение базируется на следующих моментах:
1. Добавить пользователей в одну группу
2. Позволить пользователям из группы все права на общую папку
3. Создавать файлы в общей папке с группой в которую входят пользователи
     
```text
# create developer group
sudo addgroup developer
# create ivan-dev user
sudo useradd -m -s /bin/bash ivan-dev
sudo passwd ivan-dev # 1
# create petr-dev user
sudo useradd -m -s /bin/bash petr-dev
sudo passwd petr-dev # 1
# add ivan-dev to developer
sudo usermod -aG developer ivan-dev
# add petr-dev to developer
sudo usermod -aG developer petr-dev
cat /etc/group | grep developer
# developer:x:1005:ivan-dev,petr-dev
sudo mkdir /var/dev-share/
# change group owner to developer
# drwxr-xr-x  2 root root     4096 июн 14 23:22 dev-share
sudo chgrp developer /var/dev-share/
# drwxr-xr-x  2 root developer 4096 июн 14 23:22 dev-share
touch /var/dev-share/ivan.txt # ivan-dev@gb-udt:/tmp$
# touch: cannot touch '/var/dev-share/ivan.txt': Permission denied
sudo chmod g+w /var/dev-share/
touch /var/dev-share/ivan.txt # ivan-dev@gb-udt:/tmp$
ls -l /var/dev-share/
# total 0
# -rw-rw-r-- 1 ivan-dev ivan-dev 0 июн 14 23:30 ivan.txt

# set group ID upon execution
sudo chmod g+s /var/dev-share/
su - ivan-dev
echo 'ivan-dev' > /var/dev-share/dev.txt
ls -l /var/dev-share/
-rw-rw-r-- 1 ivan-dev developer 9 июн 14 23:36 dev.txt
-rw-rw-r-- 1 ivan-dev ivan-dev  0 июн 14 23:30 ivan.txt
exit
su - petr-dev
cat /var/dev-share/dev.txt # petr-dev@gb-udt:~$
ivan-dev
exit
```

5. * Создать в директории для совместной работы поддиректорию для
обмена файлами, но чтобы удалять файлы могли только их создатели.

Решить с помощью указания опции u=w, g=r не получится, поскольку
группа не сможет редактировать, так как `w` - как для редактирования,
так и для удаления.

А вот использование специального бита - sticky, который говорит, что
файл может удалить лишь владелец — нам подходит.

```text
petr-dev@gb-udt:~$ su - ivan-dev 
Password: 
ivan-dev@gb-udt:~$ mkdir /var/dev-share/file-share
ivan-dev@gb-udt:~$ ls -l /var/dev-share/
total 8
-rw-rw-r-- 1 ivan-dev developer    9 июн 14 23:36 dev.txt
drwxrwsr-x 2 ivan-dev developer 4096 июн 15 12:43 file-share
-rw-rw-r-- 1 ivan-dev ivan-dev     0 июн 14 23:30 ivan.txt
ivan-dev@gb-udt:~$ chmod +t /var/dev-share/file-share/
ivan-dev@gb-udt:~$ ls -l /var/dev-share/
total 8
-rw-rw-r-- 1 ivan-dev developer    9 июн 14 23:36 dev.txt
drwxrwsr-t 2 ivan-dev developer 4096 июн 15 12:43 file-share
-rw-rw-r-- 1 ivan-dev ivan-dev     0 июн 14 23:30 ivan.txt
ivan-dev@gb-udt:~$ echo 'shared-file-of-ivan' > /var/dev-share/file-share/shared-file-of-ivan.txt
ivan-dev@gb-udt:~$ exit
logout
petr-dev@gb-udt:~$ su - petr-dev 
Password: 
petr-dev@gb-udt:~$ echo 'thx ivan' >> /var/dev-share/file-share/shared-file-of-ivan.txt
petr-dev@gb-udt:~$ cat /var/dev-share/file-share/shared-file-of-ivan.txt
shared-file-of-ivan
thx ivan
petr-dev@gb-udt:~$ rm /var/dev-share/file-share/shared-file-of-ivan.txt
rm: cannot remove '/var/dev-share/file-share/shared-file-of-ivan.txt': Operation not permitted
petr-dev@gb-udt:~$ exit
logout
petr-dev@gb-udt:~$ su - ivan-dev 
Password: 
ivan-dev@gb-udt:~$ rm /var/dev-share/file-share/shared-file-of-ivan.txt
ivan-dev@gb-udt:~$ ls -l /var/dev-share/file-share/
total 0
```

6. * Создать директорию, в которой есть несколько файлов. Сделать так,
чтобы открыть файлы можно было, только зная имя файла, а через ls
список файлов посмотреть было нельзя.

Если убрать из директории право на выполнение, то нельзя получить
список файлов внутри директории.

```text
a@gb-udt:/tmp$ ls -al /tmp/ninja-files/
ls: cannot access '/tmp/ninja-files/file1.txt': Permission denied
ls: cannot access '/tmp/ninja-files/..': Permission denied
ls: cannot access '/tmp/ninja-files/.': Permission denied
ls: cannot access '/tmp/ninja-files/file2.txt': Permission denied
total 0
d????????? ? ? ? ?            ? .
d????????? ? ? ? ?            ? ..
-????????? ? ? ? ?            ? file1.txt
-????????? ? ? ? ?            ? file2.txt
```

То есть просто забрать права на x выполнение папки не получится,
как и забрав все права у файлов в папке. Так как x - это получение
информации из `inode`.

Перечитал документацию по правам папки — надо забрать право `r`.
```text
a@gb-udt:/tmp$ mkdir ninja-files
a@gb-udt:/tmp$ chmod -r ninja-files
a@gb-udt:/tmp$ ls -l .
d-wx-wx--x 2 a    a    4096 июн 15 13:17 ninja-files
drwx------ 3 root root 4096 июн 14 09:41 snap.snap-store
a@gb-udt:/tmp$ echo 'file-2.txt' > /tmp/ninja-files/file2.txt
a@gb-udt:/tmp$ ls /tmp/ninja-files/
ls: cannot open directory '/tmp/ninja-files/': Permission denied
a@gb-udt:/tmp$ cat /tmp/ninja-files/file2.txt
file-2.txt
```

