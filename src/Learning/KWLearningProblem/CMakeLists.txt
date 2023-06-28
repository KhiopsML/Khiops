# Exceptions are allowed only for KWLearningProject
if(NOT MSVC)
  set_source_files_properties(KWLearningProject.cpp PROPERTIES COMPILE_FLAGS -fexceptions)
endif(NOT MSVC)

# Set up the library
add_library(
  KWLearningProblem STATIC
  KWAnalysisResults.cpp
  KWAnalysisResultsView.cpp
  KWAnalysisSpec.cpp
  KWAnalysisSpecView.cpp
  KWCrashTestParametersView.cpp
  KWLearningProblem.cpp
  KWLearningProblemActionView.cpp
  KWLearningProblemComputeStats.cpp
  KWLearningProblemHelpCard.cpp
  KWLearningProblemTrain.cpp
  KWLearningProblemView.cpp
  KWLearningProject.cpp
  KWModelingAdvancedSpecView.cpp
  KWModelingSpec.cpp
  KWModelingSpecView.cpp
  KWRecoderSpec.cpp
  KWRecoderSpecView.cpp
  KWSystemParametersView.cpp)
set_khiops_options(KWLearningProblem)
target_include_directories(KWLearningProblem PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(
  KWLearningProblem
  PUBLIC KDDomainKnowledge
         DTForest
         KIInterpretation
         KWDRRuleLibrary
         KWDataPreparation
         KWUserInterface
         SNBPredictor)
