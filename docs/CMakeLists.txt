find_package(Python3 3.6 REQUIRED)

set(DOXYGEN_OUTPUT_DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR}
    CACHE PATH "Path for the generated Doxygen documentation")

foreach(file IN ITEMS Doxyfile conf.py)
  configure_file("${file}.in" "${CMAKE_CURRENT_BINARY_DIR}/${file}" @ONLY)
endforeach()

FetchContent_GetProperties(mcss
  SOURCE_DIR mcss_SOURCE_DIR)

set(mcss_script "${mcss_SOURCE_DIR}/documentation/doxygen.py")
set(config "${CMAKE_CURRENT_BINARY_DIR}/conf.py")

add_custom_target(
  docs
  COMMAND "${CMAKE_COMMAND}" -E remove_directory
          "${DOXYGEN_OUTPUT_DIRECTORY}/html" "${DOXYGEN_OUTPUT_DIRECTORY}/xml"
  COMMAND "${Python3_EXECUTABLE}" "${mcss_script}" "${config}"
  COMMENT "Building documentation using Doxygen and m.css"
  WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
  VERBATIM)

if(NOT CMAKE_SKIP_INSTALL_RULES)
  set(CMAKE_INSTALL_DOCDIR ${CMAKE_INSTALL_DATAROOTDIR}/doc/MyProj)
  install(DIRECTORY ${DOXYGEN_OUTPUT_DIRECTORY}/html
          DESTINATION ${CMAKE_INSTALL_DOCDIR})
endif()
