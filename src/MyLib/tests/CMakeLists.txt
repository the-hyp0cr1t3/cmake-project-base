include(GoogleTest)

add_executable(MyProj_mylib_tests mylib_tests.cc)
target_link_libraries(MyProj_mylib_tests PRIVATE MyProj::mylib gtest gmock gtest_main)

gtest_discover_tests(MyProj_mylib_tests
  TEST_PREFIX MyProj.
  # WORKING_DIRECTORY ""
  PROPERTIES
    LABELS MyProjLib
)