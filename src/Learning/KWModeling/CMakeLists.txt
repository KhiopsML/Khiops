add_library(
  KWModeling STATIC
  KWAttributeConstructionReport.cpp
  KWAttributeConstructionSpec.cpp
  KWBenchmarkClassSpec.cpp
  KWBenchmarkSpec.cpp
  KWClassifierPostOptimizer.cpp
  KWDRNBPredictor.cpp
  KWDRPredictor.cpp
  KWDataPreparationBase.cpp
  KWDataPreparationClass.cpp
  KWLearningBenchmark.cpp
  KWLearningBenchmarkBivariate.cpp
  KWLearningBenchmarkUnivariate.cpp
  KWPredictor.cpp
  KWPredictorBaseline.cpp
  KWPredictorBivariate.cpp
  KWPredictorDataGrid.cpp
  KWPredictorEvaluation.cpp
  KWPredictorEvaluationTask.cpp
  KWPredictorNaiveBayes.cpp
  KWPredictorReport.cpp
  KWPredictorSelectionScore.cpp
  KWPredictorSelectiveNaiveBayes.cpp
  KWPredictorSelectiveNaiveBayesOptimization.cpp
  KWPredictorSpec.cpp
  KWPredictorUnivariate.cpp
  KWRecodingSpec.cpp
  KWSelectionParameters.cpp
  KWTrainParameters.cpp
  KWTrainedPredictor.cpp)
set_khiops_options(KWModeling)
target_include_directories(KWModeling PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(KWModeling PUBLIC KDDomainKnowledge KWDataPreparation)
