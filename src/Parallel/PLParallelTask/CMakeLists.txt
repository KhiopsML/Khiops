add_library(
  PLParallelTask STATIC
  PLErrorWithIndex.cpp
  PLFileConcatenater.cpp
  PLIncrementalStats.cpp
  PLParallelTask.cpp
  PLSerializer.cpp
  PLSharedObject.cpp
  PLSharedVariable.cpp
  PLSharedVector.cpp
  PLShared_HostResource.cpp
  PLShared_ObjectArray.cpp
  PLShared_ObjectDictionary.cpp
  PLShared_ObjectList.cpp
  PLShared_ResourceRequirement.cpp
  PLShared_SampleObject.cpp
  PLShared_TaskResourceGrant.cpp
  PLSlaveState.cpp
  PLTaskDriver.cpp
  PLTracer.cpp
  RMParallelResourceDriver.cpp
  RMParallelResourceManager.cpp
  RMTaskResourceGrant.cpp
  RMTaskResourceRequirement.cpp)
set_khiops_options(PLParallelTask)
target_include_directories(PLParallelTask PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(PLParallelTask PUBLIC RMResourceManager $<$<BOOL:${MPI}>:PLMPI>)
