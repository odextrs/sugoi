import QtQuick
import qs.config

Rectangle {
    height: 34
    color: Colour.surfaceContainer
    radius: 8

    property alias text: inputField.text;

    TextInput {
        id: inputField
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        activeFocusOnPress: true
        color: "white"
        font.pixelSize: 18
    }
}