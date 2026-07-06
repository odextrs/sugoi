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
        color: "red" // temp for dev
        anchors.fill: parent
    }

    Grid {
        columns: ShellStates.flags.bar.barVertical
        rows: !ShellStates.flags.bar.barVertical
        horizontalItemAlignment: ShellStates.flags.bar.barVertical? Grid.AlignHCenter : undefined
        verticalItemAlignment: ShellStates.flags.bar.barVertical? undefined : Grid.AlignVCenter
        anchors {
            left: ShellStates.flags.bar.barVertical ? undefined : parent.left
            top: ShellStates.flags.bar.barVertical ? parent.top : undefined
            horizontalCenter: ShellStates.flags.bar.barVertical ? parent.horizontalCenter : undefined
            verticalCenter: ShellStates.flags.bar.barVertical ? undefined : parent.verticalCenter
        }
    }
}