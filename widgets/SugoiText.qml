import QtQuick
import qs.config

//https://doc.qt.io/qt-6/qml-qtquick-fontloader.html
Text {
    text: ""
    font.family: jetBrainsMono.font
    color: messageColor

    property string messageColor: Colour.primary

    FontLoader {
        id: jetBrainsMono
        source: Qt.resolvedUrl("../assets/fonts/JetBrainsMonoNerdFontMono-Regular.ttf")
    }
}