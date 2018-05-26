cmake_minimum_required(VERSION 3.9.6)
include(FindPkgConfig)
project(gsf_3names_read)

pkg_search_module(GSF REQUIRED libgsf-1)

include_directories(${GSF_INCLUDE_DIRS})
add_definitions(${GSF_CFLAGS_OTHER})
add_executable(gsf_3names_read src/main.c)
target_link_libraries(gsf_3names_read ${GSF_LIBRARIES})
