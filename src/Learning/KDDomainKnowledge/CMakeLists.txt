add_library(
  KDDomainKnowledge STATIC
  KDClassBuilder.cpp
  KDClassCompliantRules.cpp
  KDConstructedRule.cpp
  KDConstructionDomain.cpp
  KDConstructionRule.cpp
  KDDomainConstraint.cpp
  KDEntity.cpp
  KDFeatureConstruction.cpp
  KDMultiTableFeatureConstruction.cpp
  KDMultinomialSampleGenerator.cpp
  KDSelectionOperandAnalyser.cpp
  KDSelectionOperandDataSampler.cpp
  KDSelectionOperandSamplingTask.cpp
  KDTextFeatureConstruction.cpp
  KDTextFeatureSpec.cpp
  KDTextTokenSampleCollectionTask.cpp
  KDTokenFrequency.cpp)

set_khiops_options(KDDomainKnowledge)

target_include_directories(KDDomainKnowledge PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(KDDomainKnowledge PUBLIC KWDataPreparation)
