include(code-coverage)

# =============================
# Define targets
# =============================
add_library(MyProj_mylib mylib.cc)
add_library(MyProj::mylib ALIAS MyProj_mylib)
set_target_properties(MyProj_mylib PROPERTIES OUTPUT_NAME mylib)

target_include_directories(MyProj_mylib
  SYSTEM PUBLIC "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
         "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>")

target_code_coverage(MyProj_mylib AUTO)


# =============================
# Testing
# =============================
if(BUILD_TESTING)
  include(GoogleTest)

  add_executable(MyProj_mylib_test mylib.test.cc)

  target_link_libraries(MyProj_mylib_test
    PRIVATE MyProj::mylib GTest::gtest GTest::gmock GTest::gtest_main)

  gtest_discover_tests(MyProj_mylib_test
    TEST_PREFIX MyProj.
    PROPERTIES
      LABELS MyProj.Lib
    # WORKING_DIRECTORY ""
  )

  # target_code_coverage(MyProj_mylib_test AUTO EXCLUDE ${gtest_SOURCE_DIR}/*)
endif()


# =============================
# Packaging
# =============================
install(
  TARGETS MyProj_mylib
  EXPORT MyProj_Runtime
  LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}" COMPONENT MyProj_Runtime
  ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}" COMPONENT MyProj_Runtime
  RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}" COMPONENT MyProj_Runtime)
