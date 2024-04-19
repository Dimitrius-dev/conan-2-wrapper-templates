#include "temp.h"
#include <vector>
#include <string>

int main() {
    temp();

    std::vector<std::string> vec;
    vec.push_back("test_package");

    temp_print_vector(vec);
}
