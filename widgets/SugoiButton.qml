import QtQuick
import qs.config

Rectangle {
    id: root

    property string text: ""
    property string tooltip: ""

    Behavior on color {
        ColorAnimation {
            duration: 500
            easing.type: Easing.BezierSpline
        }
    }

    // vv replace with SugoiText because SugoiText :thumbsup: 👍
    SugoiText {
        text: text
    }

    MouseArea {
        anchors.fill: parent
        ///  so if I remove one of these, its no longer accepted
        // nope
        // oh shit since this is a qs.widget we should add a property
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: (mouse) => {
            switch (mouse.button) {
                case Qt.LeftButton:
                    console.log("m1 registered")
                    break;
                case Qt.RightButton:
                    console.log("Right clicked!!!")
                    break;
                case Qt.MiddleButton:
                    console.log("m3 clicked!!!")
            }
        }
    }
}
//https://doc.qt.io/qt-6/qml-qtquick-mousearea.html
//maybe add right click and middle click function too, like just a place holder
// hm/
// wait im looking at DMS implementation, we dont need m1 m2 m3 hmmm
// well we do if we want to have m2 menus, but where tho
//oh shit also icon and text
