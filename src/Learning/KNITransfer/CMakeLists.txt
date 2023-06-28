add_executable(
  KNITransfer
  KNIDatabaseTransferView.cpp
  KNIRecodeFile.cpp
  KNIRecodeMTFiles.cpp
  KNITest.cpp
  KNITransfer.cpp
  KNITransferProblem.cpp
  KNITransferProblemView.cpp
  KNITransferProject.cpp)
set_khiops_options(KNITransfer)
target_link_libraries(KNITransfer PUBLIC KhiopsNativeInterface KWLearningProblem DTForest KMDRRuleLibrary
                                         PLParallelTask)
