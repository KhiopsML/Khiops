add_library(
  MHHistograms STATIC
  MHBin.cpp
  MHContinuousLimits.cpp
  MHDataSubset.cpp
  MHDiscretizerHistogramMODL.cpp
  MHDiscretizerHistogramMODL_fp.cpp
  MHEnumHistogramCost.cpp
  MHFloatingPointFrequencyTableBuilder.cpp
  MHHistogram.cpp
  MHHistogramSpec.cpp
  MHHistogramSpecView.cpp
  MHHistogramVector.cpp
  MHHistogramVector_fp.cpp
  MHKMHistogramCost.cpp
  MHMODLHistogramCost.cpp
  MHMODLHistogramCost_fp.cpp
  MHNMLStat.cpp
  MHTruncationDiscretizerHistogramMODL_fp.cpp
  MHTruncationFloatingPointFrequencyTableBuilder.cpp)
set_khiops_options(MHHistograms)
target_include_directories(MHHistograms PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(MHHistograms KWData KWDataPreparation KWUtils)
