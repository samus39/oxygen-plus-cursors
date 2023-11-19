set(PREFIX dioxygen)

macro(add_cursor cursor color theme dpi)
    set(theme_dir ${CMAKE_BINARY_DIR}/${PREFIX}-${theme})
    add_custom_command(OUTPUT ${theme_dir}/svg/${cursor}_${dpi}.svg
                       DEPENDS ${MAKE_SVG} ${CMAKE_CURRENT_SOURCE_DIR}/colors.in ${SVGDIR}/${cursor}.svg
                       COMMAND ${CMAKE_COMMAND} -Dconfig=${CMAKE_CURRENT_SOURCE_DIR}/colors.in
                                                -Dinput=${SVGDIR}/${cursor}.svg
                                                -Doutput=${theme_dir}/svg/${cursor}_${dpi}.svg
                                                -P ${MAKE_SVG}
                      )
    add_custom_command(OUTPUT ${theme_dir}/png/${cursor}_${dpi}.png
                       DEPENDS ${theme_dir}/svg/${cursor}_${dpi}.svg
                       COMMAND ${INKSCAPE} --without-gui --export-dpi=${dpi}
                                           --export-png=${theme_dir}/png/${cursor}_${dpi}.png
                                           ${theme_dir}/svg/${cursor}_${dpi}.svg
                      )
endmacro(add_cursor)

macro(add_x_cursor theme cursor dpis)
    set(theme_dir ${CMAKE_BINARY_DIR}/${PREFIX}-${theme})
    set(inputs)
    foreach(dpi ${dpis})
        foreach(png ${${cursor}_inputs})
            string(REPLACE ".png" "_${dpi}.png" png "${png}")
            list(APPEND inputs ${theme_dir}/png/${png})
        endforeach(png)
    endforeach(dpi)
    add_custom_command(OUTPUT ${theme_dir}/config/${cursor}.in
                       DEPENDS ${MAKE_CONFIG} ${CONFIGDIR}/${cursor}.in
                       COMMAND ${CMAKE_COMMAND} -Dconfig=${CONFIGDIR}/${cursor}.in
                                                -Doutput=${theme_dir}/config/${cursor}.in
                                                -Ddpis="${dpis}"
                                                -P ${MAKE_CONFIG}
                      )
    add_custom_command(OUTPUT ${theme_dir}/cursors/${cursor}
                       DEPENDS ${inputs} ${theme_dir}/config/${cursor}.in
                       COMMAND ${XCURSORGEN} -p ${theme_dir}/png
                                             ${theme_dir}/config/${cursor}.in
                                             ${theme_dir}/cursors/${cursor}
                      )
endmacro(add_x_cursor)

file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/packages)
macro(add_theme color theme dpis)
    set(theme_name ${PREFIX}-${theme})
    set(theme_dir ${CMAKE_BINARY_DIR}/${theme_name})
    file(MAKE_DIRECTORY ${theme_dir}/png)
    file(MAKE_DIRECTORY ${theme_dir}/svg)
    file(MAKE_DIRECTORY ${theme_dir}/config)
    file(MAKE_DIRECTORY ${theme_dir}/cursors)
    set(${theme}_cursors)
    foreach(dpi ${dpis})
        foreach(svg ${SVGS})
            string(REGEX REPLACE ".*/" "" cursor ${svg})
            string(REGEX REPLACE "[.]svg" "" cursor ${cursor})
            add_cursor(${cursor} ${color} ${theme} ${dpi})
        endforeach(svg)
    endforeach(dpi)
    foreach(cursor ${CURSORS})
        add_x_cursor(${theme} ${cursor} "${dpis}")
        list(APPEND ${theme}_cursors ${theme_dir}/cursors/${cursor})
    endforeach(cursor)
    foreach(link ${LINKS})
        file(READ "${link}" link_to)
        string(REGEX REPLACE ".*/" "" cursor ${link})
        string(REGEX REPLACE "[.]link" "" cursor ${cursor})
        add_custom_command(OUTPUT ${theme_dir}/cursors/${cursor}
                           DEPENDS ${link}
                           COMMAND ${LN} -sf ${link_to} ${theme_dir}/cursors/${cursor}
                          )
        list(APPEND ${theme}_cursors ${theme_dir}/cursors/${cursor})
    endforeach(link)
    add_custom_target(theme-${theme} ALL DEPENDS ${${theme}_cursors})
    set(index_file ${theme_dir}/index.theme)
    add_custom_command(OUTPUT ${index_file}
                       DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/index.theme
                       COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/index.theme ${index_file}
                      )
    set(archive_file ${CMAKE_BINARY_DIR}/packages/${theme_name}.tar.bz2)
    add_custom_command(OUTPUT ${archive_file}
                       DEPENDS ${${theme}_cursors} ${index_file}
                       COMMAND ${TAR} cjf ${archive_file} ${theme_name}/cursors ${theme_name}/index.theme
                       WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                      )
    add_custom_target(package-${theme} ALL DEPENDS ${archive_file})
    set(home_install_dir $ENV{HOME}/.icons/${theme_name})
    add_custom_command(OUTPUT ${home_install_dir}
                       DEPENDS ${archive_file}
                       COMMAND ${TAR} xf ${archive_file} --recursive-unlink
                       WORKING_DIRECTORY $ENV{HOME}/.icons
                      )
    add_custom_target(home-install-${theme} DEPENDS ${home_install_dir})
    add_dependencies(home-install-all home-install-${theme})
endmacro(add_theme)
