# CMake Project template
This is an example C++ project setup using [CMake](https://cmake.org/).

## Build Instructions

Build using CMake. For more details, see [BUILDING.md](BUILDING.md).

```bash
git clone git@github.com:the-hyp0cr1t3/cmake-project-base.git
cd cmake-project-base

# Build
mkdir build
cd build
cmake ..
make

# Install
sudo make install
```


## Usage

```console
foo@bar:~$ app --help
Usage: app [options]

Optional arguments:
-h --help                               shows help message and exits [default: false]
-v --version                            prints version information and exits [default: false]
```