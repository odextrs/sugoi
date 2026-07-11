import Quickshell
import QtQuick
import qs.widgets
import qs.config

SugoiButton {
    id: root
    implicitWidth: 150
    implicitHeight: 60
    property bool isMonospace: false
    buttonBackground: root.hovered ? Colour.primary : Colour.secondaryContainer
    messageColor: root.hovered ? Colour.secondaryOn : Colour.primary
}