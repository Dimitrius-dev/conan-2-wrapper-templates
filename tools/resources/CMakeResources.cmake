cmake_minimum_required(VERSION 3.26)

execute_process(
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/build/resources
)

add_custom_target(update_resources
        COMMAND ${CMAKE_COMMAND} -E remove ${CMAKE_BINARY_DIR}/build/resources/*
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${PROJECT_SOURCE_DIR}/resources ${CMAKE_BINARY_DIR}/build/resources
        COMMAND ${CMAKE_COMMAND} -E echo "resources updated"
)