include(CMakeDependentOption)

if(PROJECT_IS_TOP_LEVEL)

  option(BUILD_SHARED_LIBS "Build libraries as shared as opposed to static" OFF)

  # Developer mode enables targets and code paths in the CMake scripts that are
  # only relevant for the developer(s)
  # Targets necessary to build the project must be provided unconditionally, so
  # consumers can trivially build and package the project
  option(MyProj_DEVELOPER_MODE "Enable developer mode" OFF)

  option(MyProj_BUILD_DOCS "Build documentation using Doxygen and m.css" ON)

  option(MyProj_BUILD_EXAMPLES "Build example programs" ON)

  option(MyProj_BUILD_TESTING "Create tests using CMake" ${MyProj_DEVELOPER_MODE})

  cmake_dependent_option(
    MyProj_ENABLE_COVERAGE
    "Build targets with code coverage instrumentation (requires GCC or Clang)" ON
    "MyProj_BUILD_TESTING" ${MyProj_DEVELOPER_MODE})

  cmake_dependent_option(
    MyProj_USE_CLANG_TIDY
    "Run clang-tidy on sources" ON
    "MyProj_DEVELOPER_MODE" OFF)

  foreach(var IN ITEMS
            MyProj_DEVELOPER_MODE
            MyProj_BUILD_DOCS
            MyProj_BUILD_EXAMPLES
            MyProj_BUILD_TESTING
            MyProj_ENABLE_COVERAGE
            MyProj_USE_CLANG_TIDY)

    message(STATUS "${var}=${${var}}")

  endforeach()

endif()