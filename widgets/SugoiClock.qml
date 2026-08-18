import Quickshell
import QtQuick

import qs.widgets
import qs.config

SugoiRectangle {
    id: root
    implicitWidth: content.width
    implicitHeight: content.height
    color: "transparent"

    property bool isVertical: false
    property int size: 14

    Grid {
        id: content
        columns: root.isVertical
        rows: !root.isVertical
        spacing: 2

        SugoiText {
            text: Qt.formatDateTime(clock.date, "hh")
            font.pixelSize: root.size
        }

        SugoiText {
            text: ":"
            visible: !root.isVertical
            font.pixelSize: root.size
        }

        SugoiText {
            text: Qt.formatDateTime(clock.date, "mm")
            font.pixelSize: root.size
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}