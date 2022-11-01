#---------------------------
# Define targets
#---------------------------
add_executable(MyProj_app main.cc)
add_executable(MyProj::MyProj_app ALIAS MyProj_app)
set_target_properties(MyProj_app PROPERTIES OUTPUT_NAME app)
target_link_libraries(MyProj_app MyProj::mylib)


#---------------------------
# Test
#---------------------------
add_test(NAME MyProj.app.NoArgs COMMAND MyProj_app)
add_test(NAME MyProj.app.WithArgs COMMAND MyProj_app 42 17)
set_tests_properties(MyProj.app.NoArgs PROPERTIES LABELS MyProj.App)
set_tests_properties(MyProj.app.WithArgs PROPERTIES LABELS MyProj.App)


#---------------------------
# Install
#---------------------------
install(
  TARGETS MyProj_app
  EXPORT MyProj_Runtime
  DESTINATION ${CMAKE_INSTALL_BINDIR}
  COMPONENT MyProj_Runtime)
