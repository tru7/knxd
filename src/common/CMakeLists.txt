add_library(common STATIC image.cpp loadimage.cpp)

INSTALL(FILES eibloadresult.h
        DESTINATION ${KNXD_INCLUDE_DIR})

