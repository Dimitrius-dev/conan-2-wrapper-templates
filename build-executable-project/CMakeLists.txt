cmake_minimum_required(VERSION 3.26)
project(conan_test LANGUAGES CXX)

# conan
set(conan "/home/belov/.local/bin/conan") # set conan path
set(conan_profile "default") # set host conan profile
include(CMakeConanProject.cmake) # including CMakeConanProject template for fast build

# resources
include(CMakeResources.cmake) # including CMakeResources for resource management

# main target
add_subdirectory(main)