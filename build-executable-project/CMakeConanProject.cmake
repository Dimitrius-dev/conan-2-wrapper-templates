cmake_minimum_required(VERSION 3.26)

message("=== connected conan project template ===")

MESSAGE(STATUS "Using toolchain file: ${CMAKE_TOOLCHAIN_FILE}")
MESSAGE(STATUS "Not using c compiler : ${CMAKE_C_COMPILER}")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)

if(conan_testing)
    set(conan_skip_test "False")
else ()
    set(conan_skip_test "True")
endif ()

# install conan index files
execute_process(
        COMMAND ${CMAKE_COMMAND} -E echo "--- execute conan install ---"
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/conanfile.txt ${CMAKE_BINARY_DIR}/conanfile.txt
        COMMAND ${conan} install ${CMAKE_BINARY_DIR}
        -s build_type=${CMAKE_BUILD_TYPE}
        --output-folder=${CMAKE_BINARY_DIR}/conan_files --build=missing
        -pr:b=${conan_profile}
        -pr:h=${conan_profile}
        -c tools.build:skip_test=${conan_skip_test}
        RESULT_VARIABLE OUTPUT
)

#message("conan output${OUTPUT}")
# link conan paths to project
include(${CMAKE_BINARY_DIR}/conan_files/conan_toolchain.cmake)