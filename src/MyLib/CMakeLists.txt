#---------------------------
# Define targets
#---------------------------
add_library(MyProj_mylib mylib.cc)
add_library(MyProj::mylib ALIAS MyProj_mylib)
set_target_properties(MyProj_mylib PROPERTIES OUTPUT_NAME mylib)

target_include_directories(MyProj_mylib
  SYSTEM PUBLIC "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
         "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>")

target_code_coverage(MyProj_mylib AUTO)


#---------------------------
# Install
#---------------------------
install(
  TARGETS MyProj_mylib
  EXPORT MyProj_Runtime
  LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}" COMPONENT MyProj_Runtime
  ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}" COMPONENT MyProj_Runtime
  RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}" COMPONENT MyProj_Runtime)
