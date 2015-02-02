
if(HAVE_USB)
  LIST(APPEND srcs usb.cpp)
endif(HAVE_USB)


include_directories ("${PROJECT_SOURCE_DIR}/src/libserver")
include_directories ("${PROJECT_SOURCE_DIR}/src/common")

include_directories (${PTHSEM_INCLUDE_DIRS})
add_definitions(${PTHSEM_DEFINITIONS})
include_directories (${LIBUSB_INCLUDE_DIRS})
add_definitions(${LIBUSB_DEFINITIONS})

LIST(APPEND srcs dummy.cpp)
add_library(usb STATIC ${srcs})

if(HAVE_USB)
  add_executable(findknxusb findknxusb.cpp)
  target_link_libraries(findknxusb usb)
  target_link_libraries(findknxusb ${LIBUSB_LDFLAGS})
  target_link_libraries(findknxusb ${PTHSEM_LDFLAGS})
endif(HAVE_USB)
