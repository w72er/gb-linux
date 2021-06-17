Создать однострочный скрипт, который создаст директории для нескольких
годов (2010–2017), в них — поддиректории для месяцев (от 01 до 12), и
в каждый из них запишет несколько файлов с произвольными записями.
Например, 001.txt, содержащий текст «Файл 001», 002.txt с текстом
«Файл 002» и т. д.

```text
a@md:~/projects/my/gb-linux/lesson-6-hw/task-2$ chmod +x create-file-tree.sh
a@md:~/projects/my/gb-linux/lesson-6-hw/task-2$ pwd
/home/a/projects/my/gb-linux/lesson-6-hw/task-2
a@md:~/projects/my/gb-linux/lesson-6-hw/task-2$ cd /tmp/
a@md:/tmp$ mkdir task-2
a@md:/tmp$ cd task-2/
a@md:/tmp/task-2$ /home/a/projects/my/gb-linux/lesson-6-hw/task-2/create-file-tree.sh 
a@md:/tmp/task-2$ ls
2010  2011  2012  2013  2014  2015  2016  2017
a@md:/tmp/task-2$ ls 2010
01  02  03  04  05  06  07  08  09  10  11  12
a@md:/tmp/task-2$ ls 2010/02
001.txt  002.txt  003.txt
a@md:/tmp/task-2$ cat 2010/02/002.txt 
Файл 002
```
