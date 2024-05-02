cmake_minimum_required(VERSION 3.26)
project(hello LANGUAGES CXX)

macro(get_file url arg)
    if(NOT EXISTS ${CMAKE_SOURCE_DIR}/${arg})
        file(DOWNLOAD ${url} ${CMAKE_SOURCE_DIR}/${arg})
    endif ()
endmacro()

set(CMAKE_CXX_STANDARD 20)

set(GCC_MICRO_ARCH        "x86-64")
get_file( # ConanProfileGen.cmake
    https://raw.githubusercontent.com/Dimitrius-dev/conan-2-wrapper-templates/dev/tools/set_micro_arch/ConanProfileGen.cmake
    ConanProfileGen.cmake)
include(ConanProfileGen.cmake)


set(conan "/usr/local/bin/conan") # set conan path
set(conan_profile "${CMAKE_SOURCE_DIR}/gen_conan_profile") # set host conan profile

set(lib_url https://raw.githubusercontent.com/Dimitrius-dev/conan-2-wrapper-templates/dev/tools/conan_lib)
get_file(${lib_url}/conanfile.py         "conanfile.py")
get_file(${lib_url}/ConanLibPreset.cmake "ConanLibPreset.cmake")
include(ConanLibPreset.cmake)