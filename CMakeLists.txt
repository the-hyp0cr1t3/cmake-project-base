cmake_minimum_required(VERSION 3.23)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(
    FATAL_ERROR
    "In-source builds are not supported. "
    "Please read the BUILDING document before trying to build this project. "
    "You may need to delete 'CMakeCache.txt' and 'CMakeFiles/' first."
  )
endif()

project(
  MyProj
  VERSION 0.0.0.0
  DESCRIPTION ""
  HOMEPAGE_URL "https://github.com/the-hyp0cr1t3/cmake-project-base"
  LANGUAGES CXX)

option(BUILD_TESTING "Create tests using CMake" OFF)
option(BUILD_MCSS_DOCS "Build documentation using Doxygen and m.css" OFF)
option(BUILD_SHARED_LIBS "Build libraries as shared as opposed to static" OFF)


# ----- Project wide setup -----

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

# Encourage user to specify a build type (e.g. Release, Debug, etc.), otherwise
# set it to Release.
if(NOT CMAKE_CONFIGURATION_TYPES)
  if(NOT CMAKE_BUILD_TYPE)
    message(STATUS "Setting build type to 'Release' as none were specified.")
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY VALUE "Release")
  endif()
endif()

if(NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
      ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR})
endif()
if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY
      ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
endif()
if(NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
      ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
endif()

# To build shared libraries in Windows, we set CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS
# to TRUE. See
# https://cmake.org/cmake/help/v3.4/variable/CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS.html
# See
# https://blog.kitware.com/create-dlls-on-windows-without-declspec-using-new-cmake-export-all-feature/
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

# Under MSVC, we set CMAKE_DEBUG_POSTFIX to "d" to add a trailing "d" to library
# built in debug mode. In this Windows user can compile, build and install the
# library in both Release and Debug configuration avoiding naming clashes in the
# installation directories.
if(MSVC)
  set(CMAKE_DEBUG_POSTFIX "d")
endif()

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS NO)

# set(CMAKE_CXX_FLAGS_DEBUG "-g")
# set(CMAKE_CXX_FLAGS_RELEASE "-O3")

if(BUILD_TESTING)
  enable_testing()
endif()

# Externally provided content
add_subdirectory(dependencies)

# Main targets built by this project
add_subdirectory(src)


if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(install-script)
endif()


if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  if(BUILD_TESTING)
    add_subdirectory(tests)
  endif()

  if(BUILD_MCSS_DOCS)
    add_subdirectory(docs)
  endif()

  add_subdirectory(packaging)
endif()
