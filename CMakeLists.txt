cmake_minimum_required (VERSION 2.6)
project (KNXD)

set (KNXD_VERSION_MAJOR 0)
set (KNXD_VERSION_MINOR 9)
set (KNXD_VERSION_PATCH 0)



set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-exceptions -fno-rtti")

include_directories("${PROJECT_BINARY_DIR}")

INCLUDE (CheckIncludeFiles)

CHECK_INCLUDE_FILES ("linux/serial.h" HAVE_LINUX_LOWLATENCY)
if(HAVE_LINUX_LOWLATENCY)
  message("Linux low latency mode enabled")
else(HAVE_LINUX_LOWLATENCY)
  message("No supported low latency mode found")
endif(HAVE_LINUX_LOWLATENCY)

CHECK_INCLUDE_FILES("linux/rtnetlink.h"  HAVE_LINUX_NETLINK)
if(HAVE_LINUX_NETLINK)
  message ("Linux netlink layer available")
  SET(HAVE_SOURCE_INFO TRUE)
endif(HAVE_LINUX_NETLINK)

CHECK_INCLUDE_FILES("linux/usbdevice_fs.h" OS_LINUX)
if(OS_LINUX)
  message("Linux usb available")
  SET(HAVE_LINUX_API 1)
endif(OS_LINUX)


CHECK_INCLUDE_FILES("iphlpapi.h" HAVE_WINDOWS_IPHELPER)
if(HAVE_WINDOWS_IPHELPER)
  message("Windows IPHelper available") 
  SET(WINLIBS "-liphlpapi") 
  SET(HAVE_SOURCE_INFO TRUE)
endif(HAVE_WINDOWS_IPHELPER)

INCLUDE (CheckSymbolExists)
CHECK_SYMBOL_EXISTS(SA_SIZE "net/route.h" HAVE_SA_SIZE)

CHECK_SYMBOL_EXISTS("__APPLE__" "stdlib.h" HAVE_APPLE_DEFINED)
if(NOT HAVE_APPLE_DEFINED)
  CHECK_SYMBOL_EXISTS("__FreeBSD__" "stdlib.h" HAVE_FREEBSD_DEFINED)
endif(NOT HAVE_APPLE_DEFINED)
if(HAVE_APPLE_DEFINED OR HAVE_FREEBSD_DEFINED)
  SET(HAVE_BSD_SOURCEINFO 1)
  message("FreeBSD compatible sourceinfo")
endif(HAVE_APPLE_DEFINED OR HAVE_FREEBSD_DEFINED)


find_package(PkgConfig REQUIRED)

pkg_check_modules(PTHSEM REQUIRED pthsem>=2.0.8)


option (HAVE_FT12 "enable FT1.2 backend" ON)

option (HAVE_PEI16 "enable BCU1 kernel driver backend" OFF)

option (HAVE_TPUART "enable TPUART kernel driver backend (deprecated)" OFF)

option (HAVE_PEI16s "enable BCU1 user driver backend (very experimental)" OFF)

option (HAVE_TPUARTs "enable TPUART user driver backend" ON)

option (HAVE_EIBNETIP "enable KNXnet/IP routing backend" ON)

option (HAVE_EIBNETIPTUNNEL "enable EIBnet/IP tunneling backend" ON)

if(HAVE_EIBNETIPTUNNEL AND NOT DEFINED HAVE_SOURCE_INFO)
    message(FATAL_ERROR "not all needed functions for KNXnet/IP tunneling backend available")
endif(HAVE_EIBNETIPTUNNEL AND NOT DEFINED HAVE_SOURCE_INFO)

option (HAVE_USB "Build with usb support" OFF)

if(HAVE_USB)
  pkg_check_modules(LIBUSB REQUIRED libusb-1.0>=1.0.10)
endif(HAVE_USB)


option (HAVE_NCN5120 "enable NCN5120 backend" OFF)

option (HAVE_EIBNETIPSERVER "enable EIBnet/IP server frontend" ON)

if(HAVE_EIBNETIPSERVER AND NOT DEFINED HAVE_SOURCE_INFO)
  message(FATAL_ERROR "not all needed functions for EIBnet/IP server available")
endif(HAVE_EIBNETIPSERVER AND NOT DEFINED HAVE_SOURCE_INFO)

option (HAVE_GROUPCACHE "enable Group Cache" ON)

find_program(INDENT indent)
find_program(JAR NAMES fastjar jar)
find_program(JAVAC NAMES "gcj -C" javac)

option (BUILD_JAVA "build java client library" OFF)
if(BUILD_JAVA)
  if(NOT DEFINED JAVAC)
    message(FATAL_ERROR "no java compiler found")
  endif(NOT DEFINED JAVAC)
  if(NOT DEFINED JAR)
    message(FATAL_ERROR "jar not found")
  endif(NOT DEFINED JAR)
endif(BUILD_JAVA)

option (BUILD_EXAMPLES "build example programs" OFF)

option (USE_NOLIBSTDC "don't use function from libstdc++" OFF)
if(USE_NOLIBSTDC)
  SET(CMAKE_CXX_COMPILER ${CMAKE_C_COMPILER})
endif(USE_NOLIBSTDC)

option (KNXD_INSTALL_EXAMPLES "install example programs" ON)

if(NOT DEFINED KNXD_BIN_DIR)
  SET(KNXD_BIN_DIR "bin")
endif()
if(NOT DEFINED KNXD_LIB_DIR)
  SET(KNXD_LIB_DIR "lib")
endif()
if(NOT DEFINED KNXD_EXAMPLES_DIR)
  SET(KNXD_EXAMPLES_DIR "share/knxd/examples")
endif()
if(NOT DEFINED KNXD_INCLUDE_DIR)
  SET(KNXD_INCLUDE_DIR "include")
endif()

configure_file (
  "${PROJECT_SOURCE_DIR}/config.h.in"
  "${PROJECT_BINARY_DIR}/config.h"
  )

add_subdirectory (src)
add_subdirectory (doc)
add_subdirectory (tests)

