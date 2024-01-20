# Conan-executable-project template
___
### Описание
___
Использования пакетного менеджера Conan 2.0 для создания исполняемого файла.
___

### Обязательная иерархия папок и файлов
___
```
project-...
   include
      *.h
      *.hpp
   [some-directory]
      [some-subdirectory]
      [some-subdirectory]
      *.*
      ...
      CMakeLists.txt   
   resources
      *.*
   CMakeLists.txt
   conanfile.txt or conanfile.py  
```
Для создания проекта требуются
+ Исходники - сам проект
+ conanfile.txt файл или conanfile.py для указания требуемых зависимостей
+ Составленный CMakeLists.txt - файл сборки на cmake


### Сборка с помощью шаблона ```CMakeConanProject.cmake```
___

Для использования шаблона сборки требуется определ описать на cmake требуемую цель проекта (target)
и указать её в качестве переменной ```project_target``` перед включением файла CMakeConanProject.cmake.  
Пример ```CMakeLists.txt``` для цели ```conan_test```:
```
...
include(CMakeConanProject.cmake)
...
```

Для сборки требуется:
1. Перезапустить CMake project для генерации
последней конфигуарции проекта
2. Запустить build для cmake цели (target) ```compile_project```

### Сборка ручная
___
Для сборки требуется зайти в папку с корневым файлом CMakeLists.txt
и выполнить команды:
1. ```conan install . --output-folder=build --build=missing```
2. ```cd build```
3. ```cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release```
4. ```cmake --build .```

### Процесс сборки
___
1. Conan установит файлы, которые указывают на все требуемые зависимости из conanfile.txt (или conanfile.py)
2. Указываем cmake ранее сгененированный toolchain от conan из п.1 
3. Собираем cmake проекта

### Конфиг
___
Разбор конфиг файла ```conanfile.txt```  
```conanfile.txt```
```
[requires]
hello/0.0.1

[generators]
CMakeDeps
CMakeToolchain

[options]
hello*:shared=False
*:shared=False
*:fpic=True
```
Основные разделы
+ Раздел - ```[requires]``` Содержит названия требуемых компонентов
Пример ```hello/0.0.1``` - библиотека ```hello``` версии ```0.0.1```.
+ Раздел - ```[generators]``` Содержит названия используемых инструментов генерации
  для cmake используется связка ```CMakeDeps```, ```CMakeToolchain```.
+ Раздел - ```[options]``` Содержит опционные настройки для используемых компонентов из раздела ```requires```
  Для примера можно указать тип библиотеки hello на static с помощью ```hello*:shared=False```.
  Можно указать эти и другие параметры для всех компонентов. Если какие-то особенности не указано,
  то они будут взяты из используемого профиля (в профиле разделы называются точно так же).

Всевозможные значения для ```conanfile.txt``` можно посмотреть тут: https://docs.conan.io/2/reference/config_files/settings.html
