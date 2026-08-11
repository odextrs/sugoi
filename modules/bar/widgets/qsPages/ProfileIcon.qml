import Quickshell
import QtQuick
import qs.widgets
import qs.config

SugoiRectangle {
    id: root
    implicitWidth: 150
    implicitHeight: 125
    color: Colour.primary
    radius: 4

    Image {
        id: pfpImage
        anchors.fill: parent
        anchors.margins: 3
        source: Quickshell.env("HOME") + "/.local/state/quickshell/user/profile.jpg" // quickshell exclusive pfp... maybe not a great idea
        fillMode: Image.PreserveAspectCrop
        smooth: true
        antialiasing: true
    }
}