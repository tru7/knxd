
SET(HEADER eibclient-int.h)
SET(NATIVE close.c  closesync.c  complete.c  io.c  openlocal.c  openremote.c  openurl.c  pollcomplete.c  pollfd.c)

SET(GEN_C_FILES 
  getapdu.c              loadimage.c         mcpropertyread.c        mprogmodeoff.c              opentconnection.c 
  getapdusrc.c           mcauthorize.c       mcpropertyscan.c        mprogmodeon.c               opentgroup.c 
  getbusmonitorpacket.c  mcconnect.c         mcpropertywrite.c       mprogmodestatus.c           opentindividual.c 
  getgroupsrc.c          mcgetmaskversion.c  mcreadadc.c             mprogmodetoggle.c           openttpdu.c 
  groupcacheclear.c      mcgetpeitype.c      mcread.c                mreadindividualaddresses.c  openvbusmonitor.c 
  groupcachedisable.c    mcprogmodeoff.c     mcrestart.c             mwriteindividualaddress.c   openvbusmonitortext.c 
  groupcacheenable.c     mcprogmodeon.c      mcsetkey.c              openbusmonitor.c            reset.c 
  groupcacheread.c       mcprogmodestatus.c  mcwrite.c               openbusmonitortext.c        sendapdu.c 
  groupcachereadsync.c   mcprogmodetoggle.c  mcwriteplain.c          opengroupsocket.c           sendgroup.c 
  groupcacheremove.c     mcpropertydesc.c    mgetmaskversion.c       opentbroadcast.c            sendtpdu.c 
  gettpdu.c              mcindividual.c      groupcachelastupdates.c openbusmonitorts.c          openvbusmonitorts.c
  getbusmonitorpacketts.c)

#BUILT_SOURCES=$(FUNCS)
#CLEANFILES=$(FUNCS)


SET(GEN_DIRECTORY "${CMAKE_BINARY_DIR}/client/c/gen")
FILE(MAKE_DIRECTORY "${GEN_DIRECTORY}")

SET(GEN_LIST_C_DIR)
foreach(_file ${GEN_C_FILES})
  get_filename_component(_base_file ${_file} NAME_WE)
  set(_inc_file "def/${_base_file}.inc")
  LIST(APPEND GEN_LIST_C_DIR "${GEN_DIRECTORY}/${_file}")
  add_custom_command(OUTPUT ${GEN_DIRECTORY}/${_file} DEPENDS ../def/${_base_file}.inc
    COMMAND
    ${CMAKE_COMMAND} -E echo '\#include \"c/eibclient-int.h\"' > ${GEN_DIRECTORY}/${_file} &&
    ${CMAKE_COMMAND} -E echo '\#include \"${_inc_file}\"' >> ${GEN_DIRECTORY}/${_file}
  )
endforeach(_file ${GEN_C_FILES})

#	echo '#include "c/eibclient-int.h"' > $@ 
#	echo '#include "def/'`basename $@|sed -e "s/\.c/.inc/g"`'"' >> $@


include_directories ("${PROJECT_SOURCE_DIR}/src/include")
include_directories ("${PROJECT_SOURCE_DIR}/src/common")
include_directories ("${PROJECT_SOURCE_DIR}/src/client")

add_library(knxdclient ${NATIVE} ${GEN_LIST_C_DIR})
add_library(knxdclient_shared SHARED ${NATIVE} ${GEN_LIST_C_DIR})
set_target_properties(knxdclient_shared PROPERTIES OUTPUT_NAME knxdclient)

set_target_properties(knxdclient_shared PROPERTIES VERSION "0.0.0"
                                        SOVERSION 0)

INSTALL(TARGETS knxdclient knxdclient_shared
        ARCHIVE DESTINATION "${KNXD_LIB_DIR}"
        LIBRARY DESTINATION "${KNXD_LIB_DIR}")


