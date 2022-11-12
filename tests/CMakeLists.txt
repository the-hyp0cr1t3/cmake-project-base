# FetchContent_Declare(
#   googletest
#   GIT_REPOSITORY https://github.com/google/googletest.git
#   GIT_TAG 58d77fa8070e8cec2dc1ed015d66b454c8d78850  # release-1.12.1
#   FIND_PACKAGE_ARGS NAMES GTest
# )

# FetchContent_MakeAvailable(googletest)

find_package(GTest CONFIG QUIET)

if(NOT GTest_FOUND)
  message(STATUS "Googletest not installed, downloading...")

  FetchContent_Declare(
    GTest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG release-1.12.1
  )

  set(FETCHCONTENT_QUIET NO)
  FetchContent_MakeAvailable(GTest)

else()
  message(STATUS "Found Googletest: " ${GTest_DIR})

endif()

add_subdirectory(MyLib)