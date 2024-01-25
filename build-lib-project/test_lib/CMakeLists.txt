cmake_minimum_required(VERSION 3.26)
#project(PackageTest CXX)

set(test_exec package_test)
set(BUILD_SHARED_LIBS OFF)

add_executable(${test_exec}
        src/MainTest.cpp
        )

target_include_directories(${test_exec}
        PUBLIC include
)

#set(lib1 hello)
#find_package(${lib1} REQUIRED)
#include_directories(${${lib1}_INCLUDE_DIRS})

target_link_libraries(${test_exec} PUBLIC
        hello
        )