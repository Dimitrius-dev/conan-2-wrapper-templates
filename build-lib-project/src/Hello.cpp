//
// Created by Dmitrii on 14.01.2024.
//
#include <format>
#include <iostream>
#include "Hello.h"

std::string Hello::getString() {
    return "hello world v0.0.1";
}

void Hello::run() {
    for(int i = 0; i < 10; i++){
        std::cout<<std::format("iteration {}\n", i);
    }
}
