#include <MyLib/MyLib.h>

#include <iostream>

int MyLib::func(int x, int y) {
    std::cout << "Hello world from func!!" << std::endl;
    return x + y;
}