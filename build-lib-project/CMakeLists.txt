cmake_minimum_required(VERSION 3.26)
project(hello LANGUAGES CXX)

set(conan "/home/belov/.local/bin/conan") # set conan path
set(conan_profile "default") # set host conan profile
include(CMakeConanProject.cmake) # including CMakeConanProject template for fast build


add_subdirectory(lib)
add_subdirectory(test_lib)