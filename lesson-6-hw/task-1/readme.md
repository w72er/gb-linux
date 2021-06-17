Написать скрипт, который удаляет из текстового файла пустые строки и
заменяет маленькие символы на большие. Воспользуйтесь tr или SED.

```text
a@md:~/projects/my/gb-linux/lesson-6-hw/task-1$ chmod +x 
prepare-file.sh  test.txt         
a@md:~/projects/my/gb-linux/lesson-6-hw/task-1$ chmod +x prepare-file.sh 
a@md:~/projects/my/gb-linux/lesson-6-hw/task-1$ cat test.txt 
Здесь представлен текст

in MIXED CASES

with EMPTY LINES

a@md:~/projects/my/gb-linux/lesson-6-hw/task-1$ ./prepare-file.sh test.txt
a@md:~/projects/my/gb-linux/lesson-6-hw/task-1$ cat test.txt 
ЗДЕСЬ ПРЕДСТАВЛЕН ТЕКСТ
IN MIXED CASES
WITH EMPTY LINES
```
