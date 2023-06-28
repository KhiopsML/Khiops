add_library(
  KIInterpretation STATIC
  KIDRPredictor.cpp
  KIDRRegisterAllRules.cpp
  KIHowParameterView.cpp
  KIInterpretationDictionary.cpp
  KIInterpretationSpec.cpp
  KIInterpretationSpecView.cpp
  KILeverVariablesSpecView.cpp
  KIPredictorInterpretationView.cpp
  KIWhyParameterView.cpp)
target_include_directories(KIInterpretation PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(KIInterpretation PUBLIC KDDomainKnowledge KWDataPreparation KWModeling KWUserInterface)
set_khiops_options(KIInterpretation)

# Set the header to private (why?)
set_target_properties(
  KIInterpretation
  PROPERTIES PRIVATE_HEADER KIDRPredictor.h
             KIDRRegisterAllRules.h KIHowParameterView.h
             KIInterpretationDictionary.h KIInterpretationSpec.h
             KIInterpretationSpecView.h KILeverVariablesSpecView.h
             KIPredictorInterpretationView.h KIWhyParameterView.h)
