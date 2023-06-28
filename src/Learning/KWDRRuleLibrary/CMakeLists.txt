add_library(
  KWDRRuleLibrary STATIC
  KWDRAll.cpp
  KWDRCompare.cpp
  KWDRDateTime.cpp
  KWDRHashMap.cpp
  KWDRLogical.cpp
  KWDRMath.cpp
  KWDRMultiTable.cpp
  KWDRString.cpp
  KWDRStringEncrypt.cpp
  KWDRText.cpp
  KWDRTextList.cpp
  KWDRTextualAnalysis.cpp
  KWDRTextualAnalysisPROTO.cpp
  KWDRTokenCounts.cpp
  KWDRVector.cpp)
set_khiops_options(KWDRRuleLibrary)
target_include_directories(KWDRRuleLibrary PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(KWDRRuleLibrary PUBLIC KWData KWDataPreparation KWModeling)
