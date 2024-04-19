#pragma once

#include <vector>
#include <string>


#ifdef _WIN32
  #define TEMP_EXPORT __declspec(dllexport)
#else
  #define TEMP_EXPORT
#endif

TEMP_EXPORT void temp();
TEMP_EXPORT void temp_print_vector(const std::vector<std::string> &strings);
