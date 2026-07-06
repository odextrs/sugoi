import QtQuick
import qs.config

Rectangle {
    id: root

    implicitWidth: 30
    implicitHeight: 30

    color: buttonBackground

    property string buttonBackground: Colour.primary
    property string message: "" // text breaks things.
    property int messageSize: 16
    property string messageColor: Colour.primaryOn
    property string tooltip: ""

    Behavior on color {
        ColorAnimation {
            duration: 500
            easing.type: Easing.BezierSpline
        }
    }

    SugoiText {
        text: message
        font.pixelSize: messageSize
        color: messageColor
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: (mouse) => {
            switch (mouse.button) {
                case Qt.LeftButton:
                    console.log("m1 registered")
                    break;
                case Qt.RightButton:
                    console.log("Right clicked!!!")
                    break;
                case Qt.MiddleButton: //middle button no worky for some reason
                    console.log("m3 clicked!!!")
                    break;
            }
        }
    }
}
//https://doc.qt.io/qt-6/qml-qtquick-mousearea.html
