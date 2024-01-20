cmake_minimum_required(VERSION 3.26)
project(hello LANGUAGES CXX)

message("no using c compiler - ${CMAKE_C_COMPILER}")
set(CMAKE_CXX_STANDARD 20)
#set(CMAKE_CXX_STANDARD_REQUIRED ON)
#set(CMAKE_CXX_EXTENSIONS OFF)

include(CMakeConanProject.cmake) # including CMakeConanProject template for fast build

set(sources
    src/Hello.cpp
)

set(includes
    include/Hello.h
)

add_library(${CMAKE_PROJECT_NAME}
        ${sources}
)

target_include_directories(${CMAKE_PROJECT_NAME}
        PUBLIC include
)

install(TARGETS ${CMAKE_PROJECT_NAME})