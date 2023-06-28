# On utilise les exceptions seulement pour le fichier Regex.cpp
if(NOT MSVC)
  set_source_files_properties(Regexp.cpp PROPERTIES COMPILE_FLAGS -fexceptions)
endif(NOT MSVC)

add_library(
  base STATIC
  ALString.cpp
  BufferedFile.cpp
  CharVector.cpp
  CommandLine.cpp
  Ermgt.cpp
  FileCache.cpp
  FileService.cpp
  HugeBuffer.cpp
  InputBufferedFile.cpp
  Longint.cpp
  MemVector.cpp
  MemoryBufferedFile.cpp
  MemoryManager.cpp
  MemoryStatsManager.cpp
  Obarray.cpp
  Obdic.cpp
  Oblist.cpp
  OutputBufferedFile.cpp
  PLRemoteFileService.cpp
  Portability.cpp
  Regexp.cpp
  SortedList.cpp
  Standard.cpp
  SystemFile.cpp
  SystemFileDriver.cpp
  SystemFileDriverANSI.cpp
  SystemFileDriverCreator.cpp
  SystemFileDriverLibrary.cpp
  SystemResource.cpp
  TaskProgression.cpp
  TaskProgressionManager.cpp
  Timer.cpp
  UICard.cpp
  UIData.cpp
  UIElements.cpp
  UIList.cpp
  UIObject.cpp
  UIObjectArrayView.cpp
  UIObjectView.cpp
  UITaskProgression.cpp
  UIUnit.cpp
  Vector.cpp)
set_khiops_options(base)
target_include_directories(base PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
if(NOT MSVC)
  target_link_libraries(base PUBLIC ${CMAKE_DL_LIBS})
endif(NOT MSVC)
