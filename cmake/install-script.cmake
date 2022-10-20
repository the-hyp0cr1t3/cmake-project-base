include(GNUInstallDirs)
include(InstallBasicPackageFiles)
include(AddInstallRPATHSupport)
include(uninstall-target)

install_basic_package_files(MyProj
  VERSION ${MyProj_VERSION}
  COMPATIBILITY AnyNewerVersion
  EXPORT MyProj_Runtime
  VARS_PREFIX MyProj    # what's this?
  NAMESPACE MyProj::
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO)

# Enable RPATH support for installed binaries and libraries
add_install_rpath_support(
  BIN_DIRS "${CMAKE_INSTALL_FULL_BINDIR}"
  LIB_DIRS "${CMAKE_INSTALL_FULL_LIBDIR}"
  INSTALL_NAME_DIR "${CMAKE_INSTALL_FULL_LIBDIR}"
  USE_LINK_PATH)