#!/bin/bash

# Проверяем, передан ли аргумент (путь к каталогу)
if [ $# -eq 0 ]; then
    echo "Укажите путь к каталогу в качестве аргумента"
    exit 1
fi

# Переданный путь к каталогу
directory=$1

# Функция для рекурсивного обхода файлов и подкаталогов
function process_files {
    local current_directory="$1"

    for file in "$current_directory"/*; do
        # Проверяем, является ли текущий элемент файлом
        if [ -f "$file" ]; then
            # Получаем размер и права доступа файла
            size=$(du -h "$file" | cut -f1)
            permissions=$(ls -l "$file" | awk '{print $1}')

            # Выводим информацию на консоль
            echo "Файл: $file, Размер: $size, Права доступа: $permissions"
        elif [ -d "$file" ]; then
            # Если текущий элемент - подкаталог, вызываем функцию для него
            process_files "$file"
        fi
    done
}

# Вызываем функцию для начального каталога
process_files "$directory"
