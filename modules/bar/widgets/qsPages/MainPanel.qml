import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.widgets
import qs.config
import qs.services

import "miscPanels"

Item {
    id: mainQsPage

    Layout.fillWidth: true
    Layout.fillHeight: true

    GridLayout {
        columns: 3
        //rows: 4
        anchors.centerIn: parent

        ProfileIcon {
            Layout.rowSpan: 2 //columnSpan also exists, thats cool :thumbsup:
        }

        QsButton {
            message: SugoiNetwork.isEnabled ? "󰤨" : "󰤭"
            messageSize: 16
            buttonBackground: hovered ? Qt.rgba ( Colour.primary.r, Colour.primary.g, Colour.primary.b, 1.0 ) : SugoiNetwork.connected ? Colour.secondary : Qt.rgba ( Colour.secondaryContainer.r, Colour.secondaryContainer.g, Colour.secondaryContainer.b, 0.15 )
            implicitWidth: 85
            onLeftClicked: { NetworkPanel.toggle() }
        }

        QsButton {
            message: "⏻"
            implicitWidth: 60
            messageSize: 32
            //buttonBackground: "transparent"
            onLeftClicked: {
                PowerMenu.toggle()
            }
        }

        QsButton {
            message: "󰂯"
            messageSize: 20
            implicitWidth: 85
        }

        QsButton {
            message: ""
            implicitWidth: 60
            messageSize: 20
            //buttonBackground: "transparent"
        }

        QsButton {
            isMonospace: false
            messageSize: 12
            message: "<null>"
        }

        QsButton {
            Layout.columnSpan: 2
            isMonospace: false
            messageSize: 12
            message: "<null>"
        }
    }
}