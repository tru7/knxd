include_directories ("${PROJECT_SOURCE_DIR}/src/include")
include_directories ("${PROJECT_SOURCE_DIR}/src/libserver")
include_directories ("${PROJECT_SOURCE_DIR}/src/common")
include_directories ("${PROJECT_SOURCE_DIR}/src/backend")
include_directories ("${PROJECT_SOURCE_DIR}/src/usb")

include_directories (${PTHSEM_INCLUDE_DIRS})
add_definitions(${PTHSEM_DEFINITIONS})
include_directories (${LIBUSB_INCLUDE_DIRS})
add_definitions(${LIBUSB_DEFINITIONS})

if(HAVE_SOURCE_INFO)

  add_library(bcu STATIC addrtab.cpp)

  add_executable(knxd-bcuaddrtab bcuaddrtab.cpp)
  add_executable(knxd-bcuread bcuread.cpp)

  target_link_libraries(knxd-bcuaddrtab bcu)
  target_link_libraries(knxd-bcuread bcu)


  target_link_libraries(knxd-bcuaddrtab backend knxstack common usb)
  target_link_libraries(knxd-bcuread backend knxstack common usb)
  target_link_libraries(knxd-bcuaddrtab ${PTHSEM_LDFLAGS})
  target_link_libraries(knxd-bcuread ${PTHSEM_LDFLAGS})
  target_link_libraries(knxd-bcuaddrtab ${LIBUSB_LDFLAGS})
  target_link_libraries(knxd-bcuread ${LIBUSB_LDFLAGS})

  INSTALL(TARGETS knxd-bcuaddrtab knxd-bcuread
          RUNTIME DESTINATION ${KNXD_BIN_DIR})
  
endif(HAVE_SOURCE_INFO)



