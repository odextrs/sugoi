import Quickshell
import QtQuick
import qs.widgets
import qs.config

SugoiButton {
    id: root
    implicitWidth: 150
    implicitHeight: 60
    property bool isMonospace: false
    messageColor: root.hovered ? Colour.secondaryOn : Colour.primary
    buttonBackground: root.hovered ? Qt.rgba ( Colour.primary.r, Colour.primary.g, Colour.primary.b, 1.0 ) : Qt.rgba ( Colour.secondaryContainer.r, Colour.secondaryContainer.g, Colour.secondaryContainer.b, 0.15 )
}