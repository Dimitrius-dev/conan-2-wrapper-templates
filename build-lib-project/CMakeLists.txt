cmake_minimum_required(VERSION 3.26)
project(hello LANGUAGES CXX)

macro(get_file url arg)
    if(NOT EXISTS ${CMAKE_SOURCE_DIR}/${arg})
        file(DOWNLOAD ${url} ${CMAKE_SOURCE_DIR}/${arg})
    endif ()
endmacro()

set(CMAKE_CXX_STANDARD 20)

# "conan_profile_gen_with_micro_arch" plugin
set(CONAN_GEN_GCC_MICRO_ARCH        "x86-64")
get_file( # ConanProfileGen.cmake
    https://raw.githubusercontent.com/Dimitrius-dev/conan-2-wrapper-templates/dev/tools/conan_profile_gen_with_micro_arch/ConanProfileGen.cmake
    ConanProfileGen.cmake)
include(ConanProfileGen.cmake)

# "conan_lib_preset" plugin
set(conan "/usr/local/bin/conan") # set conan path
set(conan_profile "${CMAKE_SOURCE_DIR}/conan_profile.gen") # set host conan profile
set(lib_url https://raw.githubusercontent.com/Dimitrius-dev/conan-2-wrapper-templates/dev/tools/conan_lib_preset)
get_file(${lib_url}/conanfile.py         "conanfile.py")
get_file(${lib_url}/ConanLibPreset.cmake "ConanLibPreset.cmake")
include(ConanLibPreset.cmake)


SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=${CONAN_GEN_GCC_MICRO_ARCH}")
add_subdirectory(conan_lib)