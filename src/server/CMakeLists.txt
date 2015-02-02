
#AM_CPPFLAGS=-I$(top_srcdir)/src/libserver -I$(top_srcdir)/src/backend -I$(top_srcdir)/src/common -I$(top_srcdir)/src/usb $(PTH_CFLAGS) $(LIBUSB_CFLAGS)
#knxd_LDADD=../backend/libbackend.a ../libserver/libeibstack.a ../common/libcommon.a ../usb/libusb.a $(PTHSEM_LIB) $(LIBUSB_LIBS)
#BACKEND_CONF= b-EIBNETIP.h b-FT12.h b-PEI16.h b-PEI16s.h b-TPUART.h b-TPUARTs.h b-EIBNETIPTUNNEL.h b-USB.h b-NCN5120.h
#knxd_SOURCES=knxd.cpp layer2conf.h layer2create.h $(BACKEND_CONF)

include_directories ("${PROJECT_SOURCE_DIR}/src/include")
include_directories ("${PROJECT_SOURCE_DIR}/src/common")
include_directories ("${PROJECT_SOURCE_DIR}/src/libserver")
include_directories ("${PROJECT_SOURCE_DIR}/src/backend")
include_directories ("${PROJECT_SOURCE_DIR}/src/usb")

include_directories (${PTHSEM_INCLUDE_DIRS})
add_definitions(${PTHSEM_DEFINITIONS})
include_directories (${LIBUSB_INCLUDE_DIRS})
add_definitions(${LIBUSB_DEFINITIONS})


add_executable(knxd knxd.cpp)
target_link_libraries(knxd backend)
target_link_libraries(knxd knxstack)
target_link_libraries(knxd common)
target_link_libraries(knxd usb)
target_link_libraries(knxd ${LIBUSB_LDFLAGS})
target_link_libraries(knxd ${PTHSEM_LDFLAGS})

INSTALL(TARGETS knxd 
        RUNTIME DESTINATION ${KNXD_BIN_DIR})
