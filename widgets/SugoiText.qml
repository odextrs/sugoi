import QtQuick
import qs.config

//https://doc.qt.io/qt-6/qml-qtquick-fontloader.html
Text {
    text: ""
    font.family: isMonospace ? jetBrainsMono.font : googleSansFlex.font
    color: messageColor

    property bool isMonospace: true
    property color messageColor: Colour.primary

    FontLoader {
        id: jetBrainsMono
        source: Qt.resolvedUrl("../assets/fonts/jetbrains/JetBrainsMonoNerdFontMono-Regular.ttf")
    }
    FontLoader {
        id: googleSansFlex
        source: Qt.resolvedUrl("../assets/fonts/google/GoogleSansFlex-VariableFont_GRAD,ROND,opsz,slnt,wdth,wght.ttf")
    }
}