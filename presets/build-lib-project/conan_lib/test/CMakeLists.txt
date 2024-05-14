cmake_minimum_required(VERSION 3.26)
set(CMAKE_CXX_STANDARD 20)

file(GLOB_RECURSE all_sources
        "src/*.cpp"
)

set(exec_build test)
add_executable(${exec_build}
        ${all_sources}
)
target_include_directories(${exec_build} PUBLIC include)

#set(BUILD_SHARED_LIBS OFF)
#set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(test_lib GTest)
find_package(${test_lib} REQUIRED)
include_directories(${${test_lib}_INCLUDE_DIRS})

target_link_libraries(${exec_build} PUBLIC
    ${${test_lib}_LIBRARIES}
    hello
)