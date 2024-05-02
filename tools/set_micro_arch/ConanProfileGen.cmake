
message(STATUS "connected conan profile generator")
message(STATUS "generator uses only gcc, x86_64 system")

macro(check_var arg)
    if(NOT DEFINED ${arg})
        message(FATAL_ERROR "${arg} is not defined")
    endif ()
endmacro()

macro(equal_var arg val)
    if( NOT(${${arg}} STREQUAL ${val}))
        message(FATAL_ERROR "${${arg}} is not a ${val}")
    endif ()
endmacro()

check_var(GCC_MICRO_ARCH)
check_var(CMAKE_SYSTEM_NAME)
check_var(CMAKE_SYSTEM_PROCESSOR)
check_var(CMAKE_BUILD_TYPE)
check_var(CMAKE_CXX_COMPILER)
check_var(CMAKE_CXX_COMPILER_ID)
check_var(CMAKE_CXX_COMPILER_VERSION)
check_var(CMAKE_CXX_STANDARD)

equal_var(CMAKE_CXX_COMPILER_ID "GNU")
equal_var(CMAKE_SYSTEM_PROCESSOR "x86_64")

# ============================= MY_CXX_COMPILER_VERSION
set(MY_CXX_COMPILER_VERSION "")
string(REGEX MATCH "[0-9]+\.[0-9]+\.[0-9]+" match_value ${CMAKE_CXX_COMPILER_VERSION})
if(match_value STREQUAL CMAKE_CXX_COMPILER_VERSION)
    string(REGEX REPLACE "\.[0-9]+$"
            "" MY_CXX_COMPILER_VERSION
            ${match_value})
else ()
    set(MY_CXX_COMPILER_VERSION ${match_value})
endif ()

# ============================= MY_CMAKE_CXX_STANDARD
set(MY_CMAKE_CXX_STANDARD "")
if (CMAKE_CXX_EXTENSIONS)
    set(MY_CMAKE_CXX_STANDARD gnu${CMAKE_CXX_STANDARD})
else ()
    set(MY_CMAKE_CXX_STANDARD ${CMAKE_CXX_STANDARD})
endif ()

## ============================= libstdc++11
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++11")


## ============================= writing to file
file(WRITE "${CMAKE_SOURCE_DIR}/gen_conan_profile"
"[settings]
arch=x86_64
build_type=${CMAKE_BUILD_TYPE}
compiler=gcc
compiler.march=${GCC_MICRO_ARCH}
compiler.cppstd=${MY_CMAKE_CXX_STANDARD}
compiler.libcxx=libstdc++11
compiler.version=${MY_CXX_COMPILER_VERSION}
os=${CMAKE_SYSTEM_NAME}
"
)




#message("version:${CMAKE_SYSTEM_VERSION}")
#message("name:${CMAKE_SYSTEM_NAME}")
#message("arch1:${CMAKE_SYSTEM_PROCESSOR}")
#message("arch2:${CMAKE_OSX_ARCHITECTURES}")
#message("arch3:${CMAKE_CXX_COMPILER_ARCHITECTURE_ID}")
#message("build type:${CMAKE_BUILD_TYPE}")
#message("compiler name:${CMAKE_CXX_COMPILER}")
#message("compiler name(id):${CMAKE_CXX_COMPILER_ID}")
#message("compiler vers:${CMAKE_CXX_COMPILER_VERSION}")
#message("compiler cpp standard vers:${CMAKE_CXX_STANDARD}")
#message("compiler cpp lib vers:${CMAKE_CXX_STANDARD}")