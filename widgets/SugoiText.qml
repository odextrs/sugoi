import QtQuick
import qs.assets

Text {
    //https://doc.qt.io/qt-6/qml-qtquick-fontloader.html
    // FontLoader { id: webFont; source: "http://www.mysite.com/myfont.ttf" }
    FontLoader {
        id: jetBrainsMono
        source: Qt.resolvedUrl("../assets/fonts/JetBrainsMonoNerdFontMono-Regular.ttf")
        // just wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
    }
    
    Text {
        text: ""
        font: jetBrainsMono.font
    }
}

// :| alright
