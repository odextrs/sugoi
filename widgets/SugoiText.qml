import QtQuick
import qs.config
// import qs.assets
// ^^^^^^^^^^^^^^^ I don't think we need it 
// - oh nice

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