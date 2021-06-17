#!/usr/bin/env bash

for year in {2010..2017} ; do
    for month in {01..12} ; do
        mkdir -p "$year/$month"

        for filenumber in {001..003} ; do
            filename="$filenumber.txt"
            text="Файл $filenumber"
            echo "$text" > "$year/$month/$filename"
        done
    done
done
