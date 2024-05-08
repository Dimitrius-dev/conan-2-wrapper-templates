cmake_minimum_required(VERSION 3.26)
project(conan_test LANGUAGES CXX)

macro(get_file url arg)
    if(NOT EXISTS ${CMAKE_SOURCE_DIR}/${arg})
        file(DOWNLOAD ${url} ${CMAKE_SOURCE_DIR}/${arg})
    endif ()
endmacro()

set(lib_url https://raw.githubusercontent.com/Dimitrius-dev/conan-2-wrapper-templates/dev/tools)


# "conan_exec_preset" plugin
set(conan "/usr/local/bin/conan") # set conan path
set(conan_profile "default") # set host conan profile
set(conan_testing ON) # set host conan profile
get_file(${lib_url}/conan_exec_preset/ConanExecPreset.cmake "ConanExecPreset.cmake")
include(ConanExecPreset.cmake)
get_file(${lib_url}/conan_exec/conanfile.py          "conanfile.py")

# "resources" plugin
get_file(${lib_url}/resources/CMakeResources.cmake "CMakeResources.cmake")
include(CMakeResources.cmake)


# main target
add_subdirectory(main)