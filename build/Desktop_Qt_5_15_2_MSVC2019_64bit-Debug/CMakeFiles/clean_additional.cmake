# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "AutoSpectra_autogen"
  "CMakeFiles\\AutoSpectra_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\AutoSpectra_autogen.dir\\ParseCache.txt"
  )
endif()
