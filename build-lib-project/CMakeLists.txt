cmake_minimum_required(VERSION 3.26)
project(hello LANGUAGES CXX)

set(conan "/usr/local/bin/conan") # set conan path
set(conan_profile "default") # set host conan profile
include(ConanLibPreset.cmake) # including CMakeConanProject template for fast build


add_subdirectory(conan_lib)
