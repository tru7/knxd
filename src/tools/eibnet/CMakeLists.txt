

include_directories ("${PROJECT_SOURCE_DIR}/src/include")
include_directories ("${PROJECT_SOURCE_DIR}/src/libserver")
include_directories ("${PROJECT_SOURCE_DIR}/src/common")

if(HAVE_SOURCE_INFO)

  add_executable(knxd-eibnetdescribe eibnetdescribe.cpp)
  add_executable(knxd-eibnetsearch eibnetsearch.cpp)

  target_link_libraries(knxd-eibnetdescribe knxstack)
  target_link_libraries(knxd-eibnetsearch knxstack)
  target_link_libraries(knxd-eibnetdescribe ${PTHSEM_LDFLAGS})
  target_link_libraries(knxd-eibnetsearch ${PTHSEM_LDFLAGS})

  INSTALL(TARGETS knxd-eibnetdescribe knxd-eibnetsearch
          RUNTIME DESTINATION ${KNXD_BIN_DIR})

endif(HAVE_SOURCE_INFO)


