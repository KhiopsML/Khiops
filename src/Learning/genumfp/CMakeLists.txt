add_executable(genumfp MHCommandLine.cpp genumfp.cpp)

target_link_libraries(genumfp PUBLIC MHHistograms)

set_khiops_options(genumfp)
