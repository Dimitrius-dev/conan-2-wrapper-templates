#include <iostream>

#include <Hello.h>

int main() {

    Hello hello;

    std::cout << hello.getString() << std::endl;

    hello.run();

    return 0;
}