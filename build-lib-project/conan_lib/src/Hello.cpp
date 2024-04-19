//
// Created by Dmitrii on 14.01.2024.
//
//#include <format>
#include <iostream>
#include "Hello.h"

#include <spdlog/spdlog.h>

std::string Hello::getString() {
    return "hello world v0.0.1";
}

void Hello::run() {

    //spdlog::logger logger("log1");
    spdlog::set_level(spdlog::level::debug);
    spdlog::warn("da");// warn("hello warn");
    spdlog::debug("hello debug");
    spdlog::info("hello info");

}
