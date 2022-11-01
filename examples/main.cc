#include <MyLib/mylib.h>

#include <iostream>

auto string_to_int(const char *num) -> int { return atoi(num); }

auto main(int argc, char **argv) -> int {
    std::cout << "Hello world from main!!" << std::endl;
    MyLib::func(42);

    std::string str1 = "Testing";
    std::string str2 = std::move(str1);

    // Well, we use str1 after a std::move(). Not that smart :)
    // clang-tidy will find this!
    std::cout << str1 << str2;

    std::cout << "argc: " << argc << std::endl;
    for (int i = 1; i < argc; i++) { std::cout << argv[i] << std::endl; }

    return 0;
}