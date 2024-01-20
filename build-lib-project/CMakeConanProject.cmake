cmake_minimum_required(VERSION 3.26)

message("=== connected conan library template ===")

add_custom_target(create_lib
        COMMAND ${CMAKE_COMMAND} -E echo "--- create lib ---"
        COMMAND conan create .
)