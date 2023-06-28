add_library(KWUtils STATIC KWVersion.cpp LMLicenseManager.cpp LMLicenseService.cpp ProfileStats.cpp)
set_khiops_options(KWUtils)
target_include_directories(KWUtils PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(KWUtils base)
