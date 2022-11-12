cmake_minimum_required(VERSION 3.20)

project(
  MyProj
  VERSION 1.0.0
  DESCRIPTION ""
  HOMEPAGE_URL "https://github.com/the-hyp0cr1t3/cmake-project-base"
  LANGUAGES CXX C)

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
include(LinkTimeOptimization)
include(CodeCoverage)
include(SupportRPATH)
include(InstallBasicPackageFiles)
include(AddUninstallTarget)

if(${PROJECT_NAME}_DEVELOPER_MODE)
  include(ClangFormat)
  include(ClangTidy)
endif()

#---------------------------
# Build type
#---------------------------

if(PROJECT_IS_TOP_LEVEL AND NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to 'Release' as none were specified.")
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY VALUE "Release")
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
  set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard (11/14/17/20/...)")
  set(CMAKE_CXX_EXTENSIONS OFF)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)

  set(CMAKE_CXX_FLAGS_DEBUG "-g")
  set(CMAKE_CXX_FLAGS_RELEASE "-O3")

endif()

#---------------------------
# Dependencies
#---------------------------

# add_subdirectory(extern)

#---------------------------
# Sources
#---------------------------

add_subdirectory(src)

#---------------------------
# Tests
#---------------------------

add_subdirectory(tests)

#---------------------------
# Examples
#---------------------------

if(${PROJECT_NAME}_BUILD_EXAMPLES)
  add_subdirectory(examples)
endif()

#---------------------------
# Documentation
#---------------------------

if(${PROJECT_NAME}_BUILD_DOCS)
  add_subdirectory(docs)
endif()

#---------------------------
# Install
#---------------------------

# Enable RPATH support for installed binaries and libraries
add_install_rpath_support(
  BIN_DIRS "${CMAKE_INSTALL_FULL_BINDIR}"
  LIB_DIRS "${CMAKE_INSTALL_FULL_LIBDIR}"
  INSTALL_NAME_DIR "${CMAKE_INSTALL_FULL_LIBDIR}"
  USE_LINK_PATH)

install_basic_package_files(MyProj
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY AnyNewerVersion
  EXPORT MyProj
  VARS_PREFIX MyProj
  NAMESPACE MyProj::
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO)

install(
  DIRECTORY ${PROJECT_SOURCE_DIR}/include/
  DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  COMPONENT MyProj_Development
  FILES_MATCHING
    PATTERN "*.h"
    PATTERN "*.hpp"
    PATTERN "*.hxx"
)

#---------------------------
# Packaging
#---------------------------

if(PROJECT_IS_TOP_LEVEL)
  include(packaging)
endif()