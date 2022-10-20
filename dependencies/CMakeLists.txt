include(FetchContent)

if(BUILD_MCSS_DOCS)
  FetchContent_Declare(
    mcss
    GIT_REPOSITORY https://github.com/friendlyanon/m.css.git
    GIT_TAG 7ae8c129ef6ad569090f75e67787c62ee6a9fb67  # release-1
  )

  FetchContent_MakeAvailable(mcss)
endif()

if(BUILD_TESTING)
  FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG 58d77fa8070e8cec2dc1ed015d66b454c8d78850  # release-1.12.1
  )

  FetchContent_MakeAvailable(googletest)
endif()