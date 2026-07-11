import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.config

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
            message: ""
            messageSize: 32
            implicitWidth: 85
        }

        QsButton {
            message: "⏻"
            implicitWidth: 60
            messageSize: 32
            //buttonBackground: "transparent"
        }

        QsButton {
            message: "󰂯"
            messageSize: 24
            implicitWidth: 85
        }

        QsButton {
            message: ""
            implicitWidth: 60
            messageSize: 32
            //buttonBackground: "transparent"
        }

        QsButton {
            message: "we"
        }

        QsButton {
            Layout.columnSpan: 2
            message: "wewe"
        }
    }
}