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
        source: "file:///usr/share/sddm/faces/" + Quickshell.env("USER") + ".face.icon" //yes sddm only for now, pls fix future someone
        fillMode: Image.PreserveAspectCrop
        smooth: true
        antialiasing: true
    }
}