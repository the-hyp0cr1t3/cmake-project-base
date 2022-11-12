# Building with CMake

This project requires [CMake](https://cmake.org/).

## Build

To build in release mode with a single-configuration generator (eg. Unix Makefiles):
```sh
cmake -S . -B build -D CMAKE_BUILD_TYPE=Release
cmake --build build
```

To build in release mode with a multi-configuration generator (eg. Visual Studio):
```sh
cmake -S . -B build
cmake --build build --config Release
```

### Building with MSVC

Note that MSVC by default is not standards compliant and you need to pass some
flags to make it behave properly. See the `flags-windows` preset in the
[CMakePresets.json](CMakePresets.json) file for the flags and variables to provide to CMake during configuration.

### Build options

The following options can be passed to cmake for finer control.

* `MyProj_BUILD_DOCS` (default: `ON`): Builds documentation. Open `build/docs/html/index.html` to view them.
* `MyProj_BUILD_EXAMPLES` (default: `ON`): Builds example programs in `examples/`.
* `MyProj_BUILD_TESTING` (default: `OFF`): Builds tests.

<details>
    <summary>Example</summary>

```bash
cmake -S . -B build -D MyProj_BUILD_DOCS=OFF -D MyProj_BUILD_TESTING=ON
```

</details>

### Build docs

Build documentation with [Doxygen](https://doxygen.nl/) + [Sphinx](https://www.sphinx-doc.org/en/master/) + [Breathe](https://breathe.readthedocs.io/en/latest/).

Install dependencies:
```sh
pip install -r docs/requirements.txt
```

Build the docs:
```sh
cmake --build build --target docs
```

## Test

`MyProj_BUILD_TESTING` must be set to `ON` to build tests. Additionally, `MyProj_ENABLE_COVERAGE` can be turned on to enable coverage analysis using either [gcov](https://en.wikipedia.org/wiki/Gcov) or [lcov](https://wiki.documentfoundation.org/Development/Lcov).

```sh
cd build

# run tests
ctest -j4

# coverage
make ccov  # open `build/ccov/.../index.html` to view the html report
```


## Install

To install in release mode with a single-configuration generator (eg. Unix Makefiles):
```sh
cmake --install build
```

To install in release mode with a multi-configuration generator (eg. Visual Studio):
```sh
cmake --install build --config Release
```

To install to a location other than the standard one:
```sh
cmake --install build --prefix "/foo/bar/baz"
```

To uninstall:
```sh
cmake --build build --target uninstall
```
