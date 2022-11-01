#!/bin/bash
rm -rf build
cmake --preset ci-ubuntu -D CMAKE_BUILD_TYPE=DEBUG
cmake --build build