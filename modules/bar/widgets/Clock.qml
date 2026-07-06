import Quickshell
import QtQuick

import qs.widgets
import qs.config

SugoiRectangle {
    implicitWidth: content.width
    implicitHeight: content.height
    color: "transparent"

    Grid {
        id: content
        columns: ShellStates.flags.bar.barVertical
        rows: !ShellStates.flags.bar.barVertical
        spacing: 2

        SugoiText {
            text: Qt.formatDateTime(clock.date, "hh")
            font.pixelSize: 14
        }

        SugoiText {
            text: Qt.formatDateTime(clock.date, "mm")
            font.pixelSize: 14
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}