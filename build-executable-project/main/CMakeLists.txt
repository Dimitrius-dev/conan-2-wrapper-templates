cmake_minimum_required(VERSION 3.26)
set(CMAKE_CXX_STANDARD 20)

set(exec_build conan_test)
add_executable(${exec_build}
        src/main.cpp
)

set(libhello hello)
find_package(${libhello} REQUIRED)
include_directories(${${libhello}_INCLUDE_DIRS})
target_link_libraries(${exec_build} PRIVATE
        ${${libhello}_LIBRARIES}
)