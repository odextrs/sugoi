import QtQuick
// import qs.assets
// ^^^^^^^^^^^^^^^ I don't think we need it 

//https://doc.qt.io/qt-6/qml-qtquick-fontloader.html
Text {
    text: ""
    font.family: jetBrainsMono.font

    FontLoader {
        id: jetBrainsMono
        source: Qt.resolvedUrl("../assets/fonts/JetBrainsMonoNerdFontMono-Regular.ttf")
    }
}