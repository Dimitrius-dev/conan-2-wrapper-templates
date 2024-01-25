cmake_minimum_required(VERSION 3.26)

message("=== connected conan library template ===")

execute_process(
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/conanfile.py ${CMAKE_BINARY_DIR}/conanfile.py
        COMMAND ${conan} install ${CMAKE_BINARY_DIR}
        -s build_type=${CMAKE_BUILD_TYPE}
        --output-folder=${CMAKE_BINARY_DIR}/conan_files --build=missing RESULT_VARIABLE OUTPUT
)

include(${CMAKE_BINARY_DIR}/conan_files/conan_toolchain.cmake)

add_custom_target(create_lib
        COMMAND ${CMAKE_COMMAND} -E echo "--- create lib ---"
        COMMAND ${conan} create ${CMAKE_SOURCE_DIR}
)