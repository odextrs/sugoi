import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.widgets

import "widgets"

Item {
    Layout.fillHeight: true
    Layout.fillWidth: true

    SugoiRectangle {
        visible: ShellStates.flags.bar.barFloating
        color: "green" // temp for dev
        anchors.fill: parent
    }

    Grid {
        columns: ShellStates.flags.bar.barVertical
        rows: !ShellStates.flags.bar.barVertical
        horizontalItemAlignment: ShellStates.flags.bar.barVertical? Grid.AlignHCenter : undefined
        verticalItemAlignment: ShellStates.flags.bar.barVertical? undefined : Grid.AlignVCenter
        anchors {
            centerIn: parent
        }
    }
}