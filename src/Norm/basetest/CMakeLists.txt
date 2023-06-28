# On utilise les exceptions seulement pour le fichier KWLearningProject.cpp
if(NOT MSVC)
  set_source_files_properties(main.cpp PROPERTIES COMPILE_FLAGS -fexceptions)
endif(NOT MSVC)
add_executable(
  basetest
  BaseTest.cpp
  DiversTests.cpp
  UITest.cpp
  UITestActionSubObject.cpp
  UITestActionSubObjectView.cpp
  UITestClassSpec.cpp
  UITestClassSpecArrayView.cpp
  UITestClassSpecView.cpp
  UITestObject.cpp
  UITestObjectView.cpp
  UITestSubObject.cpp
  UITestSubObjectView.cpp
  main.cpp)
set_khiops_options(basetest)
target_link_libraries(basetest PUBLIC base)
