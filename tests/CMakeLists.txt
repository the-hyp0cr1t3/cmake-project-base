find_package(GTest)

if(NOT GTest_FOUND)
  message(STATUS "GTest not installed, downloading...")

  FetchContent_Declare(
    GTest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG release-1.12.1
  )

  set(FETCHCONTENT_QUIET NO)
  FetchContent_MakeAvailable(GTest)
endif()

add_subdirectory(MyLib)