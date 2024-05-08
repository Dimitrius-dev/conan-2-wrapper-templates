# Использование своей библиотеки
___
### Шаги для использования своей библиотеки

1. Создайте пустой проект;
2. Опишите свой все требуемые зависимости в файле `conanfile.py`/`conanfile.txt`;
3. Положите в проект файл `ConanExecPreset.cmake` и проинициализируйте cmake переменные:
   `conan`, `conan_profile`, `conan_testing`.

### Разбор шаблона `ConanExecPreset.cmake`

В головном файле `CMakeLists.txt` будет следующее содержимое.
```
...
# "conan_exec_preset" plugin
set(conan "/usr/local/bin/conan") # set conan path
set(conan_profile "default") # set host conan profile
set(conan_testing ON) # set host conan profile
include(ConanExecPreset.cmake)
...
```
Переменная `conan` (Пример: `"/usr/local/bin/conan`) - путь к установленному conan 2.x.  

Переменная `conan_profile` (Пример: `default`/`./my_profile`) - название используемого conan профиля или полный путь до существующего профиля.  

Переменная `conan_testing` (Пример: `ON`/`OFF`) - включение фазы тестирования для библиотек, которые будут установлены.
Фаза тестирования включается после компиляции библиотек на систему.  

___
Пример: [использование своей библиотеки](./../../../build-lib-project/doc/README_RUS.md)