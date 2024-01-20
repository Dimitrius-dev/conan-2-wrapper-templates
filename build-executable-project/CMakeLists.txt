cmake_minimum_required(VERSION 3.26)
project(conan_test LANGUAGES CXX)

set(project_target "conan_test")
include(CMakeConanProject.cmake) # including CMakeConanProject template for fast build

add_subdirectory(main)