cmake_minimum_required(VERSION 3.26)
project(hello LANGUAGES CXX)

message("no using c compiler - ${CMAKE_C_COMPILER}")
set(CMAKE_CXX_STANDARD 20)
#set(CMAKE_CXX_STANDARD_REQUIRED ON)
#set(CMAKE_CXX_EXTENSIONS OFF)


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


set(lib1 spdlog)
find_package(${lib1} REQUIRED)
include_directories(${${lib1}_INCLUDE_DIRS})

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
        ${${lib1}_LIBRARIES}
        )

install(TARGETS ${CMAKE_PROJECT_NAME})