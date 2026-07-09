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
        columns: 2
        rows: 4
        anchors.centerIn: parent

        QsButton {
            message: "1"
        }

        QsButton {
            message: "1"
        }

        QsButton {
            message: "1"
        }

        QsButton {
            message: "1"
        }

        QsButton {
            message: "1"
        }

        QsButton {
            message: "1"
        }
    }
}