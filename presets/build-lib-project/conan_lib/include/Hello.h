//
// Created by Dmitrii on 14.01.2024.
//

#pragma once

#include <string>

class Hello{
public:
    Hello() = default;
    virtual ~Hello() = default;

    std::string getString();

    void run();
};
