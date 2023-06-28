add_library(
  PLSamples STATIC
  PEFileSearchTask.cpp
  PEHelloWorldTask.cpp
  PEIOParallelTestTask.cpp
  PELullaby.cpp
  PEPi.cpp
  PEPiTask.cpp
  PEPiView.cpp
  PEProgressionTask.cpp
  PEProtocolTestTask.cpp
  PESerializerLongTestTask.cpp
  PESerializerTestTask.cpp
  PEShared_SampleObject.cpp
  main.cpp)
set_khiops_options(PLSamples)
target_include_directories(PLSamples PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(PLSamples PUBLIC PLParallelTask)
