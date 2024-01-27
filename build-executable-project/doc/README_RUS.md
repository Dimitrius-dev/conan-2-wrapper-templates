# Conan-executable-project template
___
## Описание
___
Использования пакетного менеджера Conan 2.0 для создания исполняемого файла.

## Обязательная иерархия папок и файлов
___
```
project-...
   [some-directory]
       include
          *.h
          *.hpp
          *.*
       src
          *.cpp
          *.*
       CMakeLists.txt   
   resources
      *.*
   conanfile.txt или conanfile.py 
   CMakeResources.cmake
   CMakeConanProject
   CMakeLists.txt 
```
Для создания проекта требуются:
+ Исходники - сам проект
+ conanfile.txt файл или conanfile.py для указания требуемых зависимостей
+ Составленный CMakeLists.txt - файл сборки на cmake


## Сборка с помощью шаблона ```CMakeConanProject.cmake```
___

Для использования шаблона сборки требуется указать путь до conan в качестве переменной ```project_target``` перед включением файла CMakeConanProject.cmake.  
Пример:

Пример вставки:
```
...
set(conan "/home/belov/.local/bin/conan")
include(CMakeConanProject.cmake)
...
```
Вставка должна быть перед всеми ```add_subdirectory```

Значение ```conan``` - путь до conan, укажите ваше значение.


## С использованием ```CLion```

Для сборки требуется:
1. Перезапустить CMake project для генерации
последней конфигуарции проекта
2. Запустить build для cmake цели (target)

## Без использования ```CLion```

Для сборки требуется зайти в папку с корневым файлом CMakeLists.txt
и выполнить команды:
1. ```mkdir build && cd build```
2. ```cmake ../ -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=/usr/bin/g++-11```,
   где ```DCMAKE_BUILD_TYPE``` - тип сборки, ```DCMAKE_CXX_COMPILER``` - путь к компилятору C++. Также можно указать генератор.
3. ```cmake --build . -t=conan_test```, где ```-t``` - цель (target) собираемого проекта.


## Сборка ручная (без шаблона)
___
Для сборки требуется зайти в папку с корневым файлом CMakeLists.txt
и выполнить команды:
1. ```conan install . --output-folder=build --build=missing``` - Conan установит файлы, которые указывают на все требуемые зависимости из conanfile.txt (или conanfile.py)
2. ```cd build```
3. ```cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release``` - Указываем cmake ранее сгененированный toolchain от conan из п.1
4. ```cmake --build .``` Собираем cmake проекта

## Конфиг
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



## Дополнения
___

### 1. Менеджмент Ресурсы
___
Для использования "ресурсов" в своем проекте добавьте в корневой ```CMakeLists.txt```
файле строку подключения файла ```CMakeResources.cmake```:
```
...
include(CMakeResources.cmake)
...
```
Добавляется специальная цель - ```update_resources```
, с помощью которой можно обновлять папку с ресурами
около бинарников конечной программы. Достаточно просто
запустить build цели ```update_resources```
для обновления ресурсов.