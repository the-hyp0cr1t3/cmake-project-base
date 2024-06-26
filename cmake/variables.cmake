include(CMakeDependentOption)

if(CMAKE_VERSION VERSION_LESS 3.21)
  string(
    COMPARE EQUAL
    "${CMAKE_SOURCE_DIR}" "${PROJECT_SOURCE_DIR}"
    PROJECT_IS_TOP_LEVEL
  )
endif()

option(BUILD_SHARED_LIBS "Build libraries as shared as opposed to static" OFF)

# Developer mode enables targets and code paths in the CMake scripts that are
# only relevant for the developer(s)
# Targets necessary to build the project must be provided unconditionally, so
# consumers can trivially build and package the project
option(${PROJECT_NAME}_DEVELOPER_MODE "Enable developer mode" OFF)

option(${PROJECT_NAME}_BUILD_DOCS "Build documentation using Doxygen and m.css" ON)

option(${PROJECT_NAME}_BUILD_EXAMPLES "Build example programs" ON)

option(${PROJECT_NAME}_BUILD_TESTING "Build test programs" ${${PROJECT_NAME}_DEVELOPER_MODE})

cmake_dependent_option(
  ${PROJECT_NAME}_ENABLE_COVERAGE
  "Build targets with code coverage instrumentation (requires GCC or Clang)" OFF
  "${PROJECT_NAME}_BUILD_TESTING" ${${PROJECT_NAME}_DEVELOPER_MODE})

cmake_dependent_option(
  ${PROJECT_NAME}_USE_CLANG_TIDY
  "Run clang-tidy on sources" ON
  "${PROJECT_NAME}_DEVELOPER_MODE" OFF)

foreach(var IN ITEMS
          ${PROJECT_NAME}_DEVELOPER_MODE
          ${PROJECT_NAME}_BUILD_DOCS
          ${PROJECT_NAME}_BUILD_EXAMPLES
          ${PROJECT_NAME}_BUILD_TESTING
          ${PROJECT_NAME}_ENABLE_COVERAGE
          ${PROJECT_NAME}_USE_CLANG_TIDY)

  message(STATUS "${var}=${${var}}")

endforeach()