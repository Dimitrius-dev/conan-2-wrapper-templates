cmake_minimum_required(VERSION 3.26)

set(THIS_FILENAME "${CMAKE_PROJECT_NAME}:ConanExecPreset")

message(STATUS "${THIS_FILENAME}:connected conan project template")

MESSAGE(STATUS "${THIS_FILENAME}:Using toolchain file: ${CMAKE_TOOLCHAIN_FILE}")
MESSAGE(STATUS "${THIS_FILENAME}:Not using c compiler : ${CMAKE_C_COMPILER}")

macro(check_param arg_name)
    if(NOT DEFINED ${arg_name})
        message(FATAL_ERROR "declare cmake variable - ${arg_name}")
    endif ()
    if (${${arg_name}} STREQUAL "")
        message(FATAL_ERROR "initialize cmake variable - ${arg_name}")
    endif ()
    message(STATUS "initialized ${arg_name}: ${${arg_name}}")
endmacro()

#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)
#set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)
#set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)

message(STATUS "check parameters")
check_param("conan")
check_param("conan_testing")
check_param("conan_profile")

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