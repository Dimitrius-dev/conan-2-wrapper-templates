cmake_minimum_required(VERSION 3.26)

message("=== connected conan project template ===")

MESSAGE(STATUS "Using toolchain file: ${CMAKE_TOOLCHAIN_FILE}")
MESSAGE(STATUS "Not using c compiler : ${CMAKE_C_COMPILER}")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)

# install conan index files
execute_process(
        COMMAND ${CMAKE_COMMAND} -E echo "--- execute conan install ---"
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/conanfile.txt ${CMAKE_BINARY_DIR}/conanfile.txt
        COMMAND ${conan} install ${CMAKE_BINARY_DIR}
        -s build_type=${CMAKE_BUILD_TYPE}
        --output-folder=${CMAKE_BINARY_DIR}/conan_files --build=missing RESULT_VARIABLE OUTPUT
)

#message("conan output${OUTPUT}")
# link conan paths to project
include(${CMAKE_BINARY_DIR}/conan_files/conan_toolchain.cmake)

# check main target name
# need to set project_target variable as a main target
# ------------------------------------------------------------------------------- test >
#if ("${project_target}" STREQUAL "")
#    message(FATAL_ERROR "initialize cmake variable - project_target")
#endif ()

## building main target
#add_custom_target(compile_project
#        COMMAND ${CMAKE_COMMAND} -E echo "--- compile project ${build_target} ---"
#        #COMMAND ${CMAKE_COMMAND} . -DCMAKE_TOOLCHAIN_FILE=conan_files/conan_toolchain.cmake -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
#        COMMAND ${CMAKE_COMMAND} --build . -t=${project_target} -j 4
#)
# ------------------------------------------------------------------------------- test <