include(code-coverage)

# =============================
# Define targets
# =============================
add_library(MyProj_mylib)
add_library(MyProj::mylib ALIAS MyProj_mylib)
set_target_properties(MyProj_mylib PROPERTIES OUTPUT_NAME mylib)

target_sources(MyProj_mylib
  PRIVATE
    src/MyLib.cc
  PUBLIC
    FILE_SET HEADERS
      BASE_DIRS ${CMAKE_CURRENT_LIST_DIR}/include/
      FILES include/MyLib/MyLib.h)

target_include_directories(MyProj_mylib
  PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include/MyLib>"
         "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>")

target_code_coverage(MyProj_mylib AUTO)


# =============================
# Testing
# =============================
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()


# =============================
# Packaging
# =============================
install(
  TARGETS MyProj_mylib
  EXPORT MyProj_Runtime
  LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}" COMPONENT MyProj_Runtime
  ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}" COMPONENT MyProj_Runtime
  RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}" COMPONENT MyProj_Runtime
  FILE_SET HEADERS)
