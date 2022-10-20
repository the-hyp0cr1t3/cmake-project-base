#include <MyLib/MyLib.h>

#include <iostream>

int main(int argc, char **argv) {
    std::cout << "Hello world from main!!" << std::endl;
    MyLib::func(42);

    std::cout << "argc: " << argc << std::endl;
    for (int i = 1; i < argc; i++)
        std::cout << argv[i] << std::endl;

    return 0;
}