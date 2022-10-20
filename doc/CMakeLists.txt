FetchContent_MakeAvailable(mcss)

set(DOXYGEN_OUTPUT_DIRECTORY
    "${PROJECT_BINARY_DIR}/docs"
    CACHE PATH "Path for the generated Doxygen documentation")

set(working_dir "${PROJECT_BINARY_DIR}/docs")

foreach(file IN ITEMS Doxyfile conf.py)
  configure_file("docs/${file}.in" "${working_dir}/${file}" @ONLY)
endforeach()

set(mcss_script "${mcss_SOURCE_DIR}/documentation/doxygen.py")
set(config "${working_dir}/conf.py")

add_custom_target(
  docs
  COMMAND "${CMAKE_COMMAND}" -E remove_directory
          "${DOXYGEN_OUTPUT_DIRECTORY}/html" "${DOXYGEN_OUTPUT_DIRECTORY}/xml"
  COMMAND "${Python3_EXECUTABLE}" "${mcss_script}" "${config}"
  COMMENT "Building documentation using Doxygen and m.css"
  WORKING_DIRECTORY "${working_dir}"
  VERBATIM)

# Install the documentation
# but it will not trigger a regeneration of the documentation if it is outdated
if(NOT CMAKE_SKIP_INSTALL_RULES)
  set(CMAKE_INSTALL_DOCDIR ${CMAKE_INSTALL_DATAROOTDIR}/doc/MyProj)
  install(DIRECTORY ${DOXYGEN_OUTPUT_DIRECTORY}/html
          DESTINATION ${CMAKE_INSTALL_DOCDIR})
endif()
