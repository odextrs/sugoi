pragma ComponentBehavior: Bound

import QtQuick
import qs.config

Rectangle {
    id: root

    implicitWidth: 30
    implicitHeight: 30

    color: buttonBackground

    radius: 4
    
    readonly property bool hovered: mArea.containsMouse

    property color buttonBackground: Colour.primary
    property string message: "" // text breaks things.
    property int messageSize: 16
    property color messageColor: Colour.primaryOn
    property string tooltip: ""

    signal leftClicked()
    signal rightClicked()
    signal middleClicked()

    Behavior on color {
        ColorAnimation {
            duration: 500
            easing.type: Easing.BezierSpline
        }
    }

    SugoiText {
        text: message
        font.pixelSize: messageSize
        color: root.messageColor
        anchors.centerIn: parent
    }    

    MouseArea {
        id: mArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        hoverEnabled: true

        onClicked: (mouse) => {
            switch (mouse.button) {
                case Qt.LeftButton:
                    root.leftClicked()
                    break;
                case Qt.RightButton:
                    console.log("Right clicked!!!")
                    root.rightClicked()
                    break;
                case Qt.MiddleButton:
                    console.log("m3 clicked!!!")
                    root.middleClicked()
                    break;
            }
        }
    }
}
//https://doc.qt.io/qt-6/qml-qtquick-mousearea.html
