include_directories ("${PROJECT_SOURCE_DIR}/src/include")
include_directories ("${PROJECT_SOURCE_DIR}/src/common")

SET(examples_progs busmonitor1 busmonitor2 readindividual progmodeon progmodeoff progmodetoggle progmodestatus maskver 
	writeaddress vbusmonitor1 vbusmonitor2 mprogmodeon mprogmodeoff mprogmodetoggle mprogmodestatus mmaskver 
	mpeitype madcread mread mwrite mpropread mpropwrite mpropdesc mpropscan groupread groupswrite groupwrite 
	msetkey grouplisten groupresponse groupsresponse groupsocketlisten groupsocketread mpropscanpoll 
	vbusmonitor1poll groupreadresponse groupcacheenable groupcachedisable groupcacheclear groupcacheremove 
	groupcachereadsync groupcacheread mwriteplain mrestart groupsocketwrite groupsocketswrite knxtool 
	xpropread xpropwrite groupcachelastupdates busmonitor3 vbusmonitor3 eibread-cgi eibwrite-cgi 
	vbusmonitor1time)

add_library(tools-common common.c)

foreach(prog ${examples_progs})
  add_executable(${prog} "${prog}.c")
  target_link_libraries(${prog} tools-common knxdclient)
  if(KNXD_INSTALL_EXAMPLES)
    INSTALL(TARGETS "${prog}"
          RUNTIME DESTINATION "${KNXD_EXAMPLES_DIR}/bin")
    INSTALL(FILES "${prog}.c"
          DESTINATION "${KNXD_EXAMPLES_DIR}")
  endif(KNXD_INSTALL_EXAMPLES)
endforeach()

if(KNXD_INSTALL_EXAMPLES)
  INSTALL(FILES common.c common.h
          DESTINATION "${KNXD_EXAMPLES_DIR}")
endif(KNXD_INSTALL_EXAMPLES)
