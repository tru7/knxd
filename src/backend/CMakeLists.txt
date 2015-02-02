

if(HAVE_FT12)
  list(APPEND srcs ft12.cpp lowlatency.cpp)
endif(HAVE_FT12)

if(HAVE_PEI16)
 list(APPEND srcs bcu1.cpp)
endif(HAVE_PEI16)

if(HAVE_TPUART)
  list(APPEND srcs tpuart.cpp)
endif(HAVE_TPUART)

if(HAVE_PEI16s)
 list(APPEND srcs bcu1serial.cpp lowlatency.cpp)
endif(HAVE_PEI16s)

if(HAVE_TPUARTs)
  list(APPEND srcs tpuartserial.cpp lowlatency.cpp)
endif(HAVE_TPUARTs)

if(HAVE_EIBNETIP)
  list(APPEND srcs eibnetrouter.cpp)
endif(HAVE_EIBNETIP)

if(HAVE_EIBNETIPTUNNEL)
  list(APPEND srcs eibnettunnel.cpp)
endif(HAVE_EIBNETIPTUNNEL)

if(HAVE_USB)
  list(APPEND srcs usbif.cpp)
  add_definitions(${LIBUSB_DEFINITIONS})
  include_directories(${LIBUSB_INCLUDE_DIRS})
endif(HAVE_USB)

if(HAVE_NCN5120)
  list(APPEND srcs ncn5120.cpp)
endif(HAVE_NCN5120)

list(APPEND srcs dummy.cpp)

include_directories ("${PROJECT_SOURCE_DIR}/src/libserver")
include_directories ("${PROJECT_SOURCE_DIR}/src/common")
include_directories ("${PROJECT_SOURCE_DIR}/src/usb")

include_directories (${PTHSEM_INCLUDE_DIRS})
add_definitions(${PTHSEM_DEFINITIONS})

add_library(backend STATIC ${srcs})

#noinst_LIBRARIES = libbackend.a
#AM_CPPFLAGS=-I$(top_srcdir)/src/libserver -I$(top_srcdir)/src/common -I$(top_srcdir)/src/usb $(PTH_CFLAGS) $(LIBUSB_CFLAGS)
#libbackend_a_SOURCES= $(FT12) $(PEI16) $(TPUART) $(PEI16s) $(TPUARTs) $(EIBNETIP) $(EIBNETIPTUNNEL) $(USB) $(NCN5120) dummy.cpp

