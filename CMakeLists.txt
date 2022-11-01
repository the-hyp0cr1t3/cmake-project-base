cmake_minimum_required(VERSION 3.23)

project(
  MyProj
  VERSION 0.0.0.0
  DESCRIPTION ""
  HOMEPAGE_URL "https://github.com/the-hyp0cr1t3/cmake-project-base"
  LANGUAGES CXX)


#---------------------------
# CMake modules
#---------------------------

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

include(in-source-guard)
include(variables)

if(PROJECT_IS_TOP_LEVEL)
  include(GNUInstallDirs)
  include(CTest)
endif()

include(FetchContent)
include(link-time-optimization)
include(basic-package-install)
include(support-RPATH)
include(uninstall-rules)

if(MyProj_DEVELOPER_MODE)
  include(lint-targets)
  include(clang-tidy)
endif()


#---------------------------
# Depencencies
#---------------------------

if(MyProj_BUILD_DOCS)
  FetchContent_Declare(
    mcss
    GIT_REPOSITORY https://github.com/friendlyanon/m.css.git
    GIT_TAG 7ae8c129ef6ad569090f75e67787c62ee6a9fb67)  # release-1

  FetchContent_MakeAvailable(mcss)

endif()

if(MyProj_BUILD_TESTING)
  FetchContent_Declare(
    googletest
    SYSTEM
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG 58d77fa8070e8cec2dc1ed015d66b454c8d78850  # release-1.12.1
    FIND_PACKAGE_ARGS NAMES GTest)

  FetchContent_MakeAvailable(googletest)

endif()


#---------------------------
# Build type
#---------------------------

if(PROJECT_IS_TOP_LEVEL)
  if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to 'Release' as none were specified.")
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY VALUE "Release")
  endif()
endif()


#---------------------------
# CMake options
#---------------------------

if(PROJECT_IS_TOP_LEVEL)

  # Place all executables in build/bin/
  if(NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
        ${CMAKE_CURRENT_BINARY_DIR}/bin)
  endif()

  # Place all shared libs in build/lib/
  if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY
        ${CMAKE_CURRENT_BINARY_DIR}/lib)
  endif()

  # Place all static libs in build/lib/
  if(NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
        ${CMAKE_CURRENT_BINARY_DIR}/lib)
  endif()

  # Build position independent code
  set(CMAKE_POSITION_INDEPENDENT_CODE ON)

  # Required on Windows to build shared libraries
  set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

  # Avoid config naming clashes in install directories
  if(MSVC)
    set(CMAKE_DEBUG_POSTFIX "d")
  endif()

endif()


#---------------------------
# C++ options
#---------------------------

if(PROJECT_IS_TOP_LEVEL)
  set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard (11/14/17/20/...)") # -std=c++17
  set(CMAKE_CXX_EXTENSIONS OFF)         # no gnu++17
  set(CMAKE_CXX_STANDARD_REQUIRED ON)

  set(CMAKE_CXX_FLAGS_DEBUG "-g")
  set(CMAKE_CXX_FLAGS_RELEASE "-O3")

endif()

#---------------------------
# Sources
#---------------------------

add_subdirectory(src)

#---------------------------
# Test
#---------------------------

if(MyProj_BUILD_TESTING)
  add_subdirectory(tests)
endif()

#---------------------------
# Documentation
#---------------------------

if(MyProj_BUILD_DOCS)
  add_subdirectory(docs)
endif()


#---------------------------
# Examples
#---------------------------

add_subdirectory(examples)


#---------------------------
# Install
#---------------------------

# Enable RPATH support for installed binaries and libraries
add_install_rpath_support(
  BIN_DIRS "${CMAKE_INSTALL_FULL_BINDIR}"
  LIB_DIRS "${CMAKE_INSTALL_FULL_LIBDIR}"
  INSTALL_NAME_DIR "${CMAKE_INSTALL_FULL_LIBDIR}"
  USE_LINK_PATH)

if(NOT CMAKE_SKIP_INSTALL_RULES)
  install_basic_package_files(${PROJECT_NAME}
    VERSION ${${PROJECT_NAME}_VERSION}
    COMPATIBILITY AnyNewerVersion
    EXPORT ${PROJECT_NAME}_Runtime
    VARS_PREFIX ${PROJECT_NAME}    # what's this?
    NAMESPACE ${PROJECT_NAME}::
    NO_SET_AND_CHECK_MACRO
    NO_CHECK_REQUIRED_COMPONENTS_MACRO)

  install(
    DIRECTORY ${PROJECT_SOURCE_DIR}/include/
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    FILES_MATCHING
      PATTERN "*.h"
      PATTERN "*.hpp"
      PATTERN "*.hxx"
  )

  add_subdirectory(packaging)

endif()



if(PROJECT_IS_TOP_LEVEL)
  option(MyProj_DEVELOPER_MODE "Enable developer mode" OFF)
  include(GNUInstallDirs)
endif()

option(BUILD_TESTING "Create tests using CMake" ${MyProj_DEVELOPER_MODE})
option(BUILD_MCSS_DOCS "Build documentation using Doxygen and m.css" ${MyProj_DEVELOPER_MODE})
option(BUILD_SHARED_LIBS "Build libraries as shared as opposed to static" OFF)
option(
  ENABLE_COVERAGE
  "Build targets with code coverage instrumentation (requires GCC or Clang)"
  ${MyProj_DEVELOPER_MODE})




if(MyProj_DEVELOPER_MODE)
  include(clang-tidy)
endif()

include(link-time-optimization)

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
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED YES)

set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

# Build position independent code
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Required on Windows to build shared libraries in Windows
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

# Fetch externally provided content
include(deps)

# Turn on test related commands; otherwise disable all of them.
if(BUILD_TESTING)
  enable_testing()
endif()

# Build project targets
add_subdirectory(src)

# Build project targets
add_subdirectory(examples)

# Add install and uninstall targets
if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(install-targets)
  include(uninstall-targets)
endif()


if(MyProj_DEVELOPER_MODE)
  # Add targets format-check and format-fix for developers
  include(lint-targets)

  # include(clang-tidy)
endif()


if(PROJECT_IS_TOP_LEVEL)
  # Place all executables in build/bin/
  if(NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
        ${CMAKE_CURRENT_BINARY_DIR}/bin)
  endif()

  # Place all shared libs in build/lib/
  if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY
        ${CMAKE_CURRENT_BINARY_DIR}/lib)
  endif()

  # Place all static libs in build/lib/
  if(NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
        ${CMAKE_CURRENT_BINARY_DIR}/lib)
  endif()

  if(BUILD_TESTING)
    include(CTest)
    add_subdirectory(tests)
  endif()

  if(BUILD_MCSS_DOCS)
    add_subdirectory(docs)
  endif()

  add_subdirectory(packaging)
endif()
