include(GNUInstallDirs)

include(basic-package-install)
# Export stuff, create config files and all the good stuff :)
install_basic_package_files(${PROJECT_NAME}
  VERSION ${${PROJECT_NAME}_VERSION}
  COMPATIBILITY AnyNewerVersion
  EXPORT ${PROJECT_NAME}_Runtime
  VARS_PREFIX ${PROJECT_NAME}    # what's this?
  NAMESPACE ${PROJECT_NAME}::
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO)

include(support-RPATH)
# Enable RPATH support for installed binaries and libraries
add_install_rpath_support(
  BIN_DIRS "${CMAKE_INSTALL_FULL_BINDIR}"
  LIB_DIRS "${CMAKE_INSTALL_FULL_LIBDIR}"
  INSTALL_NAME_DIR "${CMAKE_INSTALL_FULL_LIBDIR}"
  USE_LINK_PATH)