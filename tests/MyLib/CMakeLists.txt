include(GoogleTest)

add_executable(MyProj_mylib_test mylib.test.cc)

target_link_libraries(MyProj_mylib_test
  PRIVATE MyProj::mylib GTest::gtest GTest::gtest_main)

gtest_discover_tests(MyProj_mylib_test
  TEST_PREFIX MyProj.
  PROPERTIES
    LABELS MyProj.Lib
  # WORKING_DIRECTORY ""
)

# FetchContent_GetProperties(googletest)
# target_code_coverage(MyProj_mylib_test AUTO EXCLUDE ${googletest_SOURCE_DIR}/*)
target_code_coverage(MyProj_mylib_test AUTO)