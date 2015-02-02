
list(APPEND srcs common.cpp threads.cpp trace.cpp)

list(APPEND srcs lpdu.cpp tpdu.cpp apdu.cpp)

list(APPEND srcs layer3.cpp layer4.cpp layer7.cpp)

list(APPEND srcs groupcache.cpp groupcacheclient.cpp)

list(APPEND srcs management.cpp)

list(APPEND srcs client.cpp busmonitor.cpp connection.cpp managementclient.cpp)

list(APPEND srcs server.cpp localserver.cpp inetserver.cpp)

list(APPEND srcs emi1.cpp emi2.cpp cemi.cpp emi.cpp)

list(APPEND srcs eibnetip.cpp eibnetserver.cpp)

list(APPEND srcs eibusb.cpp)

include_directories ("${PROJECT_SOURCE_DIR}/src/include")
include_directories ("${PROJECT_SOURCE_DIR}/src/common")

include_directories (${PTHSEM_INCLUDE_DIRS})
add_definitions(${PTHSEM_DEFINITIONS})

add_library(knxstack STATIC ${srcs})
