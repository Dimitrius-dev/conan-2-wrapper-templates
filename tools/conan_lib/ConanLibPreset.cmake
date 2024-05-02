cmake_minimum_required(VERSION 3.26)

message("=== connected conan library template ===")

#macro(set_if_shadow_var_not_null arg_name)
#    # change variable arg_name if arg_name is not null
#    if (NOT ${${arg_name}_ex} STREQUAL "")
#        set(${arg_name} ${${arg_name}_ex})
#    endif ()
#endmacro()
#
#set_if_shadow_var_not_null("conan")
#set_if_shadow_var_not_null("conan_profile")

macro(check_item arg)
    if(NOT EXISTS "${CMAKE_SOURCE_DIR}/${arg}")
        message(FATAL_ERROR "project item: ${arg} does not exist
            [ project structure ]
            project..name:
                conan_lib:
                    include: *.h, *.hpp ...
                    src: *.cpp ...
                    test:
                        include: *.h, *.hpp ...
                        src: *.cpp ...
                        CMakeLists.txt
                    CMakeLists.txt
                conanfile.py
                CMakeLists.txt
                ...")
    endif ()
endmacro()

# mandatory project scheme
message("= check project scheme =")

check_item(conan_lib)
check_item(conan_lib/include)
check_item(conan_lib/src)
check_item(conan_lib/test)
check_item(conan_lib/test/include)
check_item(conan_lib/test/src)

check_item(CMakeLists.txt)
check_item(conanfile.py)
check_item(conan_lib/CMakeLists.txt)
check_item(conan_lib/test/CMakeLists.txt)


macro(check_param arg_name)
    if(NOT DEFINED ${arg_name})
        message(FATAL_ERROR "declare cmake variable - ${arg_name}")
    endif ()
    if (${${arg_name}} STREQUAL "")
        message(FATAL_ERROR "initialize cmake variable - ${arg_name}")
    endif ()
    message(STATUS "initialized ${arg_name}: ${${arg_name}}")
endmacro()

message(STATUS "check parameters")
check_param("conan")
check_param("conan_profile")

# lib
message("----- lib conan update -----")

execute_process(# copy conanfile
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/conanfile.py ${CMAKE_BINARY_DIR}/conan_imported_libs/conanfile.py
)

execute_process(# install dependencies
        COMMAND ${conan} install ${CMAKE_BINARY_DIR}/conan_imported_libs
        --output-folder=${CMAKE_BINARY_DIR}/conan_imported_libs --build=missing
        -s build_type=${CMAKE_BUILD_TYPE}
        -pr:b=${conan_profile}
        -pr:h=${conan_profile}
        RESULT_VARIABLE OUTPUT
)
include(${CMAKE_BINARY_DIR}/conan_imported_libs/conan_toolchain.cmake)

add_custom_target(deploy_lib
        COMMAND ${CMAKE_COMMAND} -E echo "--- create lib ---"
        COMMAND ${conan} create ${CMAKE_SOURCE_DIR} #--version 0.0.1
        -pr:b=${conan_profile}
        -pr:h=${conan_profile}
        --build=missing
)

add_custom_target(test_lib
        COMMAND ${CMAKE_COMMAND} -E echo "--- test lib ---"

        COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_BINARY_DIR}/conan_test
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/conan_lib ${CMAKE_BINARY_DIR}/conan_test
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/conanfile.py ${CMAKE_BINARY_DIR}/conan_test/conanfile.py

        COMMAND ${conan} build ${CMAKE_BINARY_DIR}/conan_test --output-folder=${CMAKE_BINARY_DIR}/conan_test #--version 0.0.1
        -pr:b=${conan_profile}
        -pr:h=${conan_profile}
        --build=missing
)