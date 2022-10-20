#include <gtest/gtest.h>
#include <MyLib/MyLib.h>

namespace {

TEST(MyLibTests, OneArg) {
    EXPECT_EQ(MyLib::func(42), 42);
}

TEST(MyLibTests, TwoArgs) {
    EXPECT_EQ(MyLib::func(42, 17), 59);
}

} // namespace