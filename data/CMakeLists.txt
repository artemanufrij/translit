install (FILES com.github.artemanufrij.translit.desktop DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/applications)

install (FILES dictionary/ru DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/${CMAKE_PROJECT_NAME}/dictionary)
install (FILES dictionary/ua DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/${CMAKE_PROJECT_NAME}/dictionary)

install (FILES icons/artemanufrij.translit.svg DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/)
install (FILES icons/32/artemanufrij.translit.svg DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/32x32/apps/)
install (FILES icons/48/artemanufrij.translit.svg DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/48x48/apps/)
install (FILES icons/artemanufrij.translit.svg DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/64x64/apps/)
install (FILES icons/artemanufrij.translit.svg DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/128x128/apps/)
