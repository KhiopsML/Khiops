add_library(
  KWDataUtils STATIC
  KWArtificialDataset.cpp
  KWChunkSorterTask.cpp
  KWDataTableSliceSet.cpp
  KWDatabaseBasicStatsTask.cpp
  KWDatabaseCheckTask.cpp
  KWDatabaseChunkBuilder.cpp
  KWDatabaseIndexer.cpp
  KWDatabaseSlicerTask.cpp
  KWDatabaseTask.cpp
  KWDatabaseTransferTask.cpp
  KWFileIndexerTask.cpp
  KWFileKeyExtractorTask.cpp
  KWFileSorter.cpp
  KWKey.cpp
  KWKeyExtractor.cpp
  KWKeyPositionFinderTask.cpp
  KWKeyPositionSampleExtractorTask.cpp
  KWKeySampleExtractorTask.cpp
  KWKeySizeEvaluatorTask.cpp
  KWSortBuckets.cpp
  KWSortedChunkBuilderTask.cpp
  KWTestDatabaseTransfer.cpp
  PLDataTableDriverTextFile.cpp
  PLDatabaseTextFile.cpp
  PLMTDatabaseTextFile.cpp
  PLSTDatabaseTextFile.cpp)
set_khiops_options(KWDataUtils)
target_include_directories(KWDataUtils PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(KWDataUtils PUBLIC KWDRRuleLibrary)
