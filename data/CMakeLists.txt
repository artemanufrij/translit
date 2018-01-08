install (FILES com.github.artemanufrij.translit.desktop DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/applications)
install (FILES com.github.artemanufrij.translit.appdata.xml DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/metainfo)

install (FILES dictionary/ru_RU DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/${CMAKE_PROJECT_NAME}/dictionary)
install (FILES dictionary/ua_UA DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/${CMAKE_PROJECT_NAME}/dictionary)
install (FILES dictionary/by_BY DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/${CMAKE_PROJECT_NAME}/dictionary)

install (FILES icons/com.github.artemanufrij.translit.svg DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/)
install (FILES icons/32/com.github.artemanufrij.translit.svg DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/32x32/apps/)
install (FILES icons/48/com.github.artemanufrij.translit.svg DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/48x48/apps/)
install (FILES icons/com.github.artemanufrij.translit.svg DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/64x64/apps/)
install (FILES icons/com.github.artemanufrij.translit.svg DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/128x128/apps/)
