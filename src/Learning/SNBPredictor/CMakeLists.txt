add_library(
  SNBPredictor STATIC
  SNBAttributeSelectionScorer.cpp
  SNBAttributeSelectionWeightCalculator.cpp
  SNBDataTableBinarySliceSet.cpp
  SNBIndexVector.cpp
  SNBPredictorSelectionDataCostCalculator.cpp
  SNBPredictorSelectiveNaiveBayes.cpp
  SNBPredictorSelectiveNaiveBayesTrainingTask.cpp
  SNBPredictorSelectiveNaiveBayesView.cpp)
set_khiops_options(SNBPredictor)
target_include_directories(SNBPredictor PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(
  SNBPredictor
  PUBLIC KWData
         KWDataPreparation
         KWDataUtils
         KWDRRuleLibrary
         KWModeling
         KWUtils
         KWDataUtils
         KWDRRuleLibrary
         KWModeling
         KWUserInterface
         KWUtils)
