cmake_minimum_required(VERSION 3.15)
project(temp CXX)




add_library(temp src/temp.cpp)
target_include_directories(temp PUBLIC include)



set_target_properties(temp PROPERTIES PUBLIC_HEADER "include/temp.h")
install(TARGETS temp)
