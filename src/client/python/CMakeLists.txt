
message(WARNING "ToDo: Implement python client with CMake")

include_directories ("${PROJECT_SOURCE_DIR}/src/include")
include_directories ("${PROJECT_SOURCE_DIR}/src/common")
include_directories ("${PROJECT_SOURCE_DIR}/src/client")

add_executable(gen-python gen.c)

SET(GEN_DIRECTORY "${CMAKE_BINARY_DIR}/client/python/gen")
FILE(MAKE_DIRECTORY "${GEN_DIRECTORY}")

add_custom_command(OUTPUT "${GEN_DIRECTORY}/gen.inc" DEPENDS gen-python
  COMMAND gen-python > "${GEN_DIRECTORY}/gen.inc")

add_custom_command(OUTPUT "${GEN_DIRECTORY}/result.inc" DEPENDS "${CMAKE_SOURCE_DIR}/src/common/eibloadresult.h"
  COMMAND
  cat ${CMAKE_SOURCE_DIR}/src/common/eibloadresult.h | grep IMG_ |
    sed -e "'s/#define \(IMG_[A-Z_0-9]\+\)  \+\([0-9]\+\)/\1 = \2/g'" > "${GEN_DIRECTORY}/result.inc"
  )

add_custom_command(OUTPUT "${GEN_DIRECTORY}/EIBConnection.py" DEPENDS "${GEN_DIRECTORY}/gen.inc" "${GEN_DIRECTORY}/result.inc"
  COMMAND
    cat ${CMAKE_CURRENT_SOURCE_DIR}/io.inc "${GEN_DIRECTORY}/gen.inc" "${GEN_DIRECTORY}/result.inc" > "${GEN_DIRECTORY}/EIBConnection.py"
  )

add_custom_target(generated-python ALL DEPENDS "${GEN_DIRECTORY}/EIBConnection.py")

INSTALL(FILES "${GEN_DIRECTORY}/EIBConnection.py" DESTINATION shared)
