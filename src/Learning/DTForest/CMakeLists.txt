add_library(
  DTForest STATIC
  DTAttributeSelection.cpp
  DTBaseLoader.cpp
  DTBaseLoaderSplitter.cpp
  DTConfig.cpp
  DTCreationReport.cpp
  DTDecisionBinaryTreeCost.cpp
  DTDecisionTree.cpp
  DTDecisionTreeCost.cpp
  DTDecisionTreeCreationTask.cpp
  DTDecisionTreeCreationTaskSequential.cpp
  DTDecisionTreeCreationTaskSequentialView.cpp
  DTDecisionTreeCreationTaskView.cpp
  DTDecisionTreeDatabaseObject.cpp
  DTDecisionTreeGlobalCost.cpp
  DTDecisionTreeNode.cpp
  DTDecisionTreeParameter.cpp
  DTDecisionTreeParameterView.cpp
  DTDecisionTreeRecursiveCost.cpp
  DTDecisionTreeSpec.cpp
  DTDiscretizerMODL.cpp
  DTForestAttributeSelection.cpp
  DTForestParameter.cpp
  DTForestParameterView.cpp
  DTGlobalTag.cpp
  DTGrouperMODL.cpp
  DTGrouperMODLBasic.cpp
  DTGrouperMODLInternal.cpp
  DTGrouperMODLOptimization.cpp
  DTStat.cpp
  DTUnivariatePartitionCost.cpp)
set_khiops_options(DTForest)
target_include_directories(DTForest PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(DTForest PUBLIC KWDataPreparation KWModeling KWUserInterface)
