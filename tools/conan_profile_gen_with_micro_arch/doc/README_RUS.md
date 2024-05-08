# Генерация conan профиля с расширением флага -march (GCC)
___
### Шаги для генерации conan профиля

1. Возьмите проект, который использует `conan`;
2. Установите расширенный набор настроек для компилятора `GCC` в системе `conan`, используя команду `conan config install https://raw.githubusercontent.com/Dimitrius-dev/conan-2-wrapper-templates/main/tools/set_micro_arch/settings_user.zip`;
3. Положите в проект файл `ConanProfileGen.cmake` и проинициализируйте __cmake переменную__:
   `CONAN_GEN_GCC_MICRO_ARCH`.

### Разбор шаблона `ConanProfileGen.cmake`
___
При применении шаблона `ConanProfileGen.cmake` в качестве значения `CONAN_GEN_GCC_MICRO_ARCH` нужно выставить одну из микроархитектур из списка `settings_user.yml`.
В результате генерации появится профиль под именем `conan_profile.gen`. 

`CMakeLists.txt`:
```
...
# "conan_profile_gen_with_micro_arch" plugin
set(CONAN_GEN_GCC_MICRO_ARCH        "x86-64")
include(ConanProfileGen.cmake)
...
```

___
Пример: [создание своей библиотеки](./../../../build-lib-project/doc/README_RUS.md)