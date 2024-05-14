# Шаблон управлениями локальными ресурсами
___
### Шаги для использования

1. Возьмите проект;
2. Положите в проект файл `CMakeResources.cmake`.

### Разбор шаблона `CMakeResources.cmake`
___
При применении шаблона `CMakeResources.cmake` создается папка `resources`, в которой можно хранить файлы лицензий, конфигурационные файлы и т.д..
Обращение к файлам должно быть через относительный путь.

Все скомпилированные исполняемые файлы __автоматически__ помещаются в папку `${CMAKE_BINARY_DIR}/build`.  

Шаблон `CMakeResources.cmake` добавляет __cmake цель__ `update_resources`, которая копирует все ресурсы из локальный папки `resources` в копию папки.
Копия папки имеет такое же имя и располагается по пути `${CMAKE_BINARY_DIR}/build/resources`.

`CMakeLists.txt`:
```
...
# "resources" plugin
include(CMakeResources.cmake)
...
```

___
Пример: [использование своей библиотеки](../../../presets/build-executable-project/doc/README_RUS.md)