file(GLOB SVGS svg/*.svg)
file(GLOB CONFIGS config/*.in)
file(GLOB LINKS config/*.link)

set(SVGDIR ${CMAKE_SOURCE_DIR}/svg)
set(CONFIGDIR ${CMAKE_SOURCE_DIR}/config)
set(MAKE_CONFIG ${CMAKE_SOURCE_DIR}/make_config.cmake)
set(MAKE_SVG ${CMAKE_SOURCE_DIR}/make_svg.cmake)
