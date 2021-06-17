#!/usr/bin/env bash

#1. Написать скрипт, который удаляет из текстового файла пустые строки и
#   заменяет маленькие символы на большие. Воспользуйтесь tr или SED.

# get file name as parameter
filename=$1

# removes empty lines
# uppercase each letter
sed -e '/^$/d' \
    -e 's/[a-zа-я]/\U&/g' \
    -i "$filename"
