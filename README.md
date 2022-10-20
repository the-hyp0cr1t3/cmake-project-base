# CMake Project template
This is an example C++ project setup using [CMake](https://cmake.org/).

## Highlights
* Lorem ipsum dolor sit amet, consectetur adipiscing elit.
* Ut volutpat odio nec justo euismod euismod.
* Morbi sed ligula vitae nibh laoreet sodales ut a mauris.
* Cras ut ligula condimentum, elementum justo vel, condimentum diam.
* Proin eget felis sit amet arcu dictum sodales.

## Build Instructions

Build using CMake. For more details, see [BUILDING.md](BUILDING.md).

```bash
git clone git@github.com:the-hyp0cr1t3/cmake-project-base.git
cd cmake-project-base

# Build
cmake -S . -B build
cmake --build build

# Install
sudo cmake --install build
```

## Usage

```console
foo@bar:~$ app --help
Usage: app [options]

Optional arguments:
-h --help                               shows help message and exits [default: false]
-v --version                            prints version information and exits [default: false]
```