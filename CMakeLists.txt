cmake_minimum_required(VERSION 3.23)

# In-source guard
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

if(PROJECT_IS_TOP_LEVEL)
  option(MyProj_DEVELOPER_MODE "Enable developer mode" OFF)
endif()

option(BUILD_TESTING "Create tests using CMake" ${MyProj_DEVELOPER_MODE})
option(BUILD_MCSS_DOCS "Build documentation using Doxygen and m.css" ${MyProj_DEVELOPER_MODE})
option(BUILD_SHARED_LIBS "Build libraries as shared as opposed to static" OFF)

# Make project cmake scripts findable
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

# Encourage users to specify a build type; otherwise set it to Release.
if(NOT CMAKE_CONFIGURATION_TYPES)
  if(NOT CMAKE_BUILD_TYPE)
    message(STATUS "Setting build type to 'Release' as none were specified.")
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY VALUE "Release")
  endif()
endif()

# Avoid config naming clashes in the installation directories
if(MSVC)
  set(CMAKE_DEBUG_POSTFIX "d")
endif()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS NO)
set(CMAKE_CXX_STANDARD_REQUIRED YES)

set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

# Build position independent code
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Required on Windows to build shared libraries in Windows
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

# Place all executables in build/bin/
if(NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
      ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR})
endif()

# Place all shared libs in build/lib/
if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY
      ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
endif()

# Place all static libs in build/lib/
if(NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
      ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
endif()

# Turn on test related commands; otherwise ignore all of them.
if(BUILD_TESTING)
  enable_testing()
endif()

# Fetch externally provided content
add_subdirectory(deps)

# Build project targets
add_subdirectory(src)

# Add install and uninstall targets
if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(install-script)
  include(uninstall-script)
endif()


if(PROJECT_IS_TOP_LEVEL)
  if(BUILD_TESTING)
    add_subdirectory(tests)
  endif()

  if(BUILD_MCSS_DOCS)
    add_subdirectory(docs)
  endif()

  add_subdirectory(packaging)
endif()
