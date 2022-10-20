include(FetchContent)

if(BUILD_MCSS_DOCS)
  FetchContent_Declare(
    mcss
    URL https://github.com/friendlyanon/m.css/releases/download/release-1/mcss.zip
    URL_MD5 00cd2757ebafb9bcba7f5d399b3bec7f
    SOURCE_DIR "${PROJECT_BINARY_DIR}/mcss"
    UPDATE_DISCONNECTED YES)

  find_package(Python3 3.6 REQUIRED)
endif()