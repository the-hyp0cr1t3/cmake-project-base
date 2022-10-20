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

### Docs

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

### Tests

Pass `BUILD_TESTING` and/or `ENABLE_COVERAGE` to enable tests and code coverage analysis respectively.
```sh
cmake -S . -B build -D BUILD_TESTING=YES -D ENABLE_COVERAGE=YES
cmake --build build
```

To run tests:
```sh
cmake --build build --target test
```

To run coverage:
```sh
cmake --build build --target ccov
```

Open `build/ccov/.../index.html` to view the html report.

The `MyProj_DEVELOPER_MODE` variable turns on `BUILD_MCSS_DOCS`, `BUILD_TESTING` and `ENABLE_COVERAGE`. So the following may also suffice:
```sh
cmake -S . -B build -D MyProj_DEVELOPER_MODE=ON
cmake --build build
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
cmake --install build --prefix "foo/bar/baz"
```