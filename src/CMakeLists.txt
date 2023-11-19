include(cursors.cmake)
include(config.cmake)
include(setup.cmake)

set(COLORS
    black
    blue
    bluecurve
    brown
    cherry
    chrome
    desert
    emerald
    green
    grey
    honeycomb
    hot_orange
    lilac
    midnight_meadow
    navy
    norway
    obsidian
    obsidian-hc
    olympus
    olympus-inv
    orchid
    oxygen
    peach
    purple
    red
    red-argentina
    sea_blue
    steel
    terra
    terra_green
    violet
    viorange
    white
    whitewater
    wonton
    yellow
    zion
   )

add_custom_target(home-install-all)

foreach(color ${COLORS})
    # CMakeLists.txt in src/theme-${color}, symlink to theme.cmake
    add_subdirectory(theme-${color})
    list(APPEND PACKAGES package-${color})
    message(STATUS "Added themes for ${color}")
endforeach(color)
