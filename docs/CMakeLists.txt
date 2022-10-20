find_package(Python3 3.6 REQUIRED)

set(DOXYGEN_OUTPUT_DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR}
    CACHE PATH "Path for the generated Doxygen documentation")

# Create doc config files with CMake values substituted in
foreach(file IN ITEMS Doxyfile conf.py)
  configure_file("${file}.in" "${CMAKE_CURRENT_BINARY_DIR}/${file}" @ONLY)
endforeach()

# FetchContent_GetProperties(mcss SOURCE_DIR mcss_SOURCE_DIR)

set(config "${CMAKE_CURRENT_BINARY_DIR}/conf.py")
set(mcss_script "${mcss_SOURCE_DIR}/documentation/doxygen.py")

add_custom_target(
  docs
  COMMAND "${CMAKE_COMMAND}" -E remove_directory
          "${DOXYGEN_OUTPUT_DIRECTORY}/html" "${DOXYGEN_OUTPUT_DIRECTORY}/xml"
  COMMAND "${Python3_EXECUTABLE}" "${mcss_script}" "${config}"
  COMMENT "Building documentation using Doxygen and m.css"
  WORKING_DIRECTORY "${DOXYGEN_OUTPUT_DIRECTORY}"
  VERBATIM)

# Manually set CMAKE_INSTALL_DOCDIR since it is determined by
# where the GNUInstallDirs module is first included.
set(CMAKE_INSTALL_DOCDIR ${CMAKE_INSTALL_DATAROOTDIR}/doc/MyProj)
install(DIRECTORY ${DOXYGEN_OUTPUT_DIRECTORY}/html
        DESTINATION ${CMAKE_INSTALL_DOCDIR})
