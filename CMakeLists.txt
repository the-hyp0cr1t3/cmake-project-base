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
include(LinkTimeOptimization)
include(CodeCoverage)
include(SupportRPATH)
include(InstallBasicPackageFiles)
include(AddUninstallTarget)

if(MyProj_DEVELOPER_MODE)
  include(ClangFormat)
  include(ClangTidy)
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
# Examples
#---------------------------

if(MyProj_BUILD_EXAMPLES)
add_subdirectory(examples)
endif()

#---------------------------
# Documentation
#---------------------------

if(MyProj_BUILD_DOCS)
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

endif()


#---------------------------
# Packaging
#---------------------------

set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
set(CPACK_PACKAGE_VENDOR "the-hyp0cr1t3")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY ${PROJECT_DESCRIPTION})
set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CPACK_PACKAGE_NAME})

set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})

if(WIN32)
  set(CPACK_GENERATOR ZIP WIX)
elseif(APPLE)
  set(CPACK_GENERATOR TGZ productbuild)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  set(CPACK_GENERATOR TGZ RPM)
else()
  set(CPACK_GENERATOR TGZ)
endif()

set(CPACK_VERBATIM_VARIABLES YES)
set(CPACK_SOURCE_IGNORE_FILES /\\.git.* /\\.git/ /\\.github/ /build/)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()