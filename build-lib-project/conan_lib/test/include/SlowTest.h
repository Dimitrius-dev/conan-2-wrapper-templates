//
// Created by Dmitrii on 14.03.2024.
//

#pragma once

#include <gtest/gtest.h>

TEST(SlowTest, p1){

    std::thread::sleep_for(std::chrono::seconds(5));

    ASSERT_TRUE(true);
}