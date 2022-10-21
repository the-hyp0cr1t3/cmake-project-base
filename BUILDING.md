# Building with CMake

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

### Build Docs

Pass `BUILD_MCSS_DOCS` to CMake to build docs.
```sh
cmake -S . -B build -D BUILD_MCSS_DOCS=YES
cmake --build build
```

After building the project, generate docs by running:
```sh
cmake --build build --target docs
```

Open `build/docs/html/index.html` to view them.

### For developers

Use `MyProj_DEVELOPER_MODE` to turn on `BUILD_MCSS_DOCS`, `BUILD_TESTING` and `ENABLE_COVERAGE`; or specify those that you need separately.

To run tests:
```sh
cmake --build build --target test

# or
cd build
ctest -j 4
```

To run coverage:
```sh
cmake --build build --target ccov
```

Open `build/ccov/.../index.html` to view the html report.

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

Note that if `BUILD_MCSS_DOCS` is true, docs have to be built first so they can be installed.

To uninstall:
```sh
cmake --build build --target uninstall
```
