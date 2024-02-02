# Conan-lib-project template
___
### Description
___
Showcase of using Conan 2.0 to create lib.
___

### Mandatory lib hierarchy 
___
```
build-lib-...
    lib
        include
            *.h
            *.*
        src
            *.cpp
            *.*
        CMakeLists.txt
    test_lib
        include
            *.h
            *.*
        src
            *.cpp
            *.*
        CMakeLists.txt
    conanfile.py
    CMakeConanProject.cmake
    CMakeLists.txt
```
Lib requirements:
+ Sources - library itself
+ Library test - the use test
+ File CMakeLists.txt - build config for cmake
+ conanfile.py - script to create conan package

### Other requirements:
+ This is a template hierarchy of files and directories. So custom filenames lead to error,
+ Directory ```lib``` is a library files which conan stores into the package, so
```CMakeLists.txt``` in ```lib``` directory should have cmake ```project(..)``` name same as the cmake project name in root ```CMakeLists.txt```.
Thus ```lib``` project connects with ```test_lib``` project.

## Build with the template ```CMakeConanProject.cmake```
___
To connect project with ```CMakeConanProject.cmake``` template change root file ```CMakeLists.txt``` with this:
```
. . .
set(conan "/home/belov/.local/bin/conan")
set(conan_profile "default")
include(CMakeConanProject.cmake)
. . .
```
This include is before all ```add_subdirectory```

Value ```conan``` - is the path to conan, set your value.
Value ```conan_profile``` - is the path to the conan profile or the profile name.


## With IDE ```CLion```
In order to create lib with conan, build cmake target -
```create_lib```

## Without IDE ```CLion```
Для создания библиотеки требуется в папке, где находится ```conanfile.py``` вызвать команду
```
conan create .
```
You can specify functionality with keys etc.

## Test
___
Create sub-project in ```test_lib``` with ```CMakeLists.txt``` to test functionality of your lib.

## Building
___
1. Conan starts to build lib with ```CMakeLists.txt``` from lib directory
2. Conan package all sources for further building
3. Conan sends package to the local cache


## Commands
___
1. Show package by command:
    ```
    conan list "package name"
    ```
   With flag ```-r=...``` scpecify ```remote``` repository as source.


2. Show package with all settings
    ```
    conan list "package name"#:*
    ```

3. Add remote repository by command
    ```
    conan remote add [repository name]
    ```
4. Send package to remote repository by command
    ```
    conan upload "package name...version" -r=[repository name]
    ```