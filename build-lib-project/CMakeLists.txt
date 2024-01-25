cmake_minimum_required(VERSION 3.26)
project(hello LANGUAGES CXX)

set(conan "/home/belov/.local/bin/conan")
include(CMakeConanProject.cmake) # including CMakeConanProject template for fast build


add_subdirectory(lib)
add_subdirectory(test_lib)