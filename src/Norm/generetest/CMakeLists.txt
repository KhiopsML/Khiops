add_executable(generetest Sample.cpp SampleArrayView.cpp SampleView.cpp generetest.cpp)
set_khiops_options(generetest)
target_link_libraries(generetest PUBLIC base)
