#!/bin/bash

# Проверяем, передан ли аргумент (путь к каталогу)
if [ $# -eq 0 ]; then
    echo "Укажите путь к каталогу в качестве аргумента"
    exit 1
fi

# Переданный путь к каталогу
directory=$1

# Используем find с параметром -print0 и xargs с параметром -0 для обработки пробелов
find "$directory" -type f -print0 | while IFS= read -r -d '' file; do
    # Получаем размер и права доступа файла
    size=$(du -h "$file" | cut -f1)
    permissions=$(ls -l "$file" | awk '{print $1}')

    # Выводим информацию на консоль
    echo "Файл: $file, Размер: $size, Права доступа: $permissions"
done
