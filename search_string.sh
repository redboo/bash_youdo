#!/bin/bash

# Проверяем, переданы ли аргументы (строка и путь к каталогу)
if [ $# -ne 2 ]; then
    echo "Укажите строку для поиска и путь к каталогу в качестве аргументов"
    exit 1
fi

# Переданные аргументы
search_string=$1
directory=$2

# Используем grep для рекурсивного поиска и awk для форматирования вывода
grep_result=$(grep -r -l "$search_string" "$directory" | awk '{size = system("du -h \""$0"\" | cut -f1"); print "Файл: " $0 ", Размер: " size}')

# Выводим результат на консоль
echo "$grep_result"
