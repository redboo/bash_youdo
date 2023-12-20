#!/bin/bash

# Проверяем, переданы ли аргументы (строка и путь к каталогу)
if [ $# -ne 2 ]; then
    echo "Укажите строку для поиска и путь к каталогу в качестве аргументов"
    exit 1
fi

# Переданные аргументы
search_string=$1
directory=$2

# Цикл для обхода файлов и подкаталогов с использованием xargs
find "$directory" -type f -print0 | while IFS= read -r -d '' file; do
    # Проверяем доступ к файлу
    if [ -r "$file" ]; then
        # Поиск строки в файле
        grep_result=$(grep -q "$search_string" "$file" && echo "найдено" || echo "не найдено")

        # Если строка найдена, выводим информацию на консоль
        if [ "$grep_result" = "найдено" ]; then
            size=$(du -h "$file" | cut -f1)
            echo "Файл: $file, Размер: $size"
        fi
    else
        # Выводим сообщение о недоступности файла
        echo "Нет доступа к файлу: $file"
    fi
done
