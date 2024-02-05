# Conan-executable-project template
___
## Description
___
Showcase of using Conan 2.0 to create project.

## Mandatory project hierarchy 
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
Project requirements:
+ Sources - library itself
+ conanfile.txt файл или conanfile.py - to set all project library dependencies
+ File CMakeLists.txt - build config for cmake

## Build with template ```CMakeConanProject.cmake```
___

To connect project with ```CMakeConanProject.cmake``` template change
root file ```CMakeLists.txt``` with this:
```
...
set(conan "/home/belov/.local/bin/conan")
set(conan_profile "default")
include(CMakeConanProject.cmake)
...
```
This include is before all ```add_subdirectory```

Value ```conan``` - is the path to conan, set your value.
Value ```conan_profile``` - is the path to the conan profile or the profile name.


## With IDE ```CLion```

Для сборки требуется:
1. Перезапустить CMake project для генерации
последней конфигуарции проекта
2. Запустить build для cmake цели (target)

## Without IDE ```CLion```

In order to build entire project, move to directory with root ```CMakeLists.txt``` and execute command sequence:
1. ```mkdir build && cd build```
2. ```cmake ../ -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=/usr/bin/g++-11```,
   где ```DCMAKE_BUILD_TYPE``` - build type, ```DCMAKE_CXX_COMPILER``` - path to c++ compiler, also generator can be specified.
3. ```cmake --build . -t=conan_test```, где ```-t``` - cmake target (target)


## Manual build (without template ```CMakeConanProject.cmake```)
___
In order to build entire project,
move to directory with root ```CMakeLists.txt``` and execute command sequence:
1. ```conan install . --output-folder=build --build=missing``` - Conan installs files which points to lib files ( all lib dependencies from conanfile.txt or conanfile.py)
2. ```cd build```
3. ```cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release``` - Set conan toolchain for cmake
4. ```cmake --build .``` build cmake project

## Config ```conanfile.txt```
___
Config file:
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
Main sections
+ Section - ```[requires]``` contains a list of dependencies (libraries).
Example ```hello/0.0.1``` - library ```hello``` version ```0.0.1```.
+ Section - ```[generators]``` contains a list of generators.
  for cmake use pair ```CMakeDeps```, ```CMakeToolchain```.
+ Section - ```[options]``` contains optional settings for all project dependencies from section ```requires```
  It could be library build type. Example: turn ```hello```  into static with ```hello*:shared=False```.
  If there are any unset settings, conan uses the settings from profile. The profile has the same sections.

All values for ```conanfile.txt``` are found here: https://docs.conan.io/2/reference/config_files/settings.html



## Optional templates
___

### 1. Resource management
___
To connect project with ```CMakeResources.cmake``` template change
root file ```CMakeLists.txt``` with this:
```
...
include(CMakeResources.cmake)
...
```
It adds special cmake target - ```update_resources```
for resource updating. You can build cmake target ```update_resources```
to update resources next to the final binaries.